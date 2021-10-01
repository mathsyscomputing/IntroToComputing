function testFunction(a=0,b=0)
	println("test function")
	return a+b
end

function externalLorenzAttractor(r0, t, σ, ρ, β)
    x = zeros(length(t))
    y = zeros(length(t))
    z = zeros(length(t))
    dt = t[2]-t[1]
    x[1] = r0[1]
    y[1] = r0[2]
    z[1] = r0[3]
    for i=2:length(t)
        x[i] = x[i-1]+dt*σ*(y[i-1]-x[i-1])
        y[i] = y[i-1]+dt*x[i-1]*(ρ-z[i-1])-dt*y[i-1]
        z[i] = z[i-1]+dt*x[i-1]*y[i-1]-dt*β*z[i-1]
    end
    return x,y,z
end
