import json
import logging
import os
import warnings
import sys

import pandas as pd
import numpy as np
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score
from sklearn.model_selection import train_test_split
from sklearn.linear_model import ElasticNet

LOG_FORMAT = "%(asctime)s: %(levelname)-8s - %(name)s - line %(lineno)3d - %(message)s"

logger = logging.getLogger(__name__)


def eval_metrics(actual, pred):
    rmse = np.sqrt(mean_squared_error(actual, pred))
    mae = mean_absolute_error(actual, pred)
    r2 = r2_score(actual, pred)
    return rmse, mae, r2


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO, format=LOG_FORMAT)
    warnings.filterwarnings("ignore")

    np.random.seed(40)

    # Read the wine-quality csv file from the URL
    csv_url = (
        "https://raw.githubusercontent.com/mlflow/mlflow/master/tests/datasets/winequality-red.csv"
    )

    try:
        data = pd.read_csv(csv_url, sep=";")
    except Exception as e:
        logger.exception(
            "Unable to download training & test CSV, check your internet connection. "
            "Error: %s",
            e
        )
        exit(1)

    # Split the data into training and test sets. (0.75, 0.25) split.
    train, test = train_test_split(data)

    # The predicted column is "quality" which is a scalar from [3, 9]
    train_x = train.drop(["quality"], axis=1)
    test_x = test.drop(["quality"], axis=1)
    train_y = train[["quality"]]
    test_y = test[["quality"]]

    alpha = float(sys.argv[1]) if len(sys.argv) > 1 else 0.5
    l1_ratio = float(sys.argv[2]) if len(sys.argv) > 2 else 0.5
    logger.info("Running with alpha=%f, l1_ratio=%f", alpha, l1_ratio)

    lr = ElasticNet(alpha=alpha, l1_ratio=l1_ratio, random_state=42)
    lr.fit(train_x, train_y)
    predicted_qualities = lr.predict(test_x)

    rmse, mae, r2 = eval_metrics(test_y, predicted_qualities)

    logger.info("Got metrics: MAE %.3g  R2 %.3g",  mae, r2)

    # Save the results
    if not os.path.exists("results"):
        os.mkdir("results")

    with open(f"results/alpha-{alpha}-l1ratio-{l1_ratio}.json", "w") as f:
        json.dump({"alpha": alpha, "l1_ratio": l1_ratio, "mae": mae, "r2": r2}, f)
