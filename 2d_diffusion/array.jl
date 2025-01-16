using Plots

struct velocity_field
    u::Array{Float64, 2}
    v::Array{Float64, 2}
end

function initiate_velocity_field!(v::velocity_field)
    for i in 1:size(v.u)[1]
        for j in 1:size(v.u)[2]
            if i > 40 && i < 60 && j > 40 && j < 60
                v.u[i,j] = 1
                v.v[i,j] = 1
            else
                v.u[i,j] = 0
                v.v[i,j] = 0
            end
        end
    end
end

function time_step(v::velocity_field, c::Float64)
    
    i,j = size(v.u)
    
    temporary_object = velocity_field(zeros(i, j), zeros(i, j))

    for x in 2:i-1
        for y in 2:j-1
            temporary_object.u[x,y] = v.u[x,y] + c * (v.u[x-1,y] + v.u[x,y-1] - 4*v.u[x,y] + v.u[x+1,y] + v.u[x,y+1])
            temporary_object.v[x,y] = v.v[x,y] + c * (v.v[x-1,y] + v.v[x,y-1] - 4*v.v[x,y] + v.v[x+1,y] + v.v[x,y+1])
        end
    end
    return temporary_object
end

function main()
    v = velocity_field(zeros(100, 100), zeros(100, 100))
    initiate_velocity_field!(v)
    initial_condition = heatmap(v.u)
    savefig(initial_condition, "initial_condition.png")
    new_v = time_step(v, 0.01)    

    for t in 1:100
        new_v = time_step(new_v, 0.1)
    end
    final_condition = heatmap(new_v.u)
    savefig(final_condition, "final_condition.png")

end

main()