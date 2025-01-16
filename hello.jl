using Plots 

function time_step(u, Δt, Δx, D)
    N = length(u)
    u_new = zeros(N)
    for i in 1:N
        if i == 1
            u_new[i] = 0
        elseif i == N
            u_new[i] = 0
        else
            u_new[i] = u[i] + D * Δt / Δx^2 * (u[i-1] - 2u[i] + u[i+1])
        end
    end
    return u_new
end

function set_initial_conditions(u)
    temporary_array = []
    N = length(u)
    for i in 1:N
        if i < N/2
            push!(temporary_array, 1)
        else
            push!(temporary_array, 0)
        end
    end
    return temporary_array
end

function main()
    time_steps = 0:0.01:1
    u = zeros(100)
    initial_condition = set_initial_conditions(u)
    new_time_step = time_step(initial_condition, 0.1, 1, 1)

    for i in eachindex(time_steps)
        new_time_step = time_step(new_time_step, 0.1, 1, 1)
    end
    p = plot(new_time_step, title = "Diffusion Equation", label = "u(x, t)", xlabel = "x", ylabel = "u")
    savefig(p, "diffusion_equation.png")
end

main()
