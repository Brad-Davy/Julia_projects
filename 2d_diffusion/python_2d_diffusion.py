from dataclasses import dataclass
import numpy as np
import timeit

@dataclass
class velocity_field:
    u: np.ndarray
    v: np.ndarray

def initialize_velocity_field(nx, ny):
    u = np.zeros((nx, ny))
    v = np.zeros((nx, ny))
    return velocity_field(u, v)

def time_step(v:velocity_field, c:float):
    nx, ny = v.u.shape
    temporary_v_u = v.u.copy()
    temporary_v = v.v.copy()
    for i in range(1, nx-1):
        for j in range(1, ny-1):
            v.u[i, j] = temporary_v_u[i, j] + c*(temporary_v_u[i+1, j] + temporary_v_u[i-1, j] + temporary_v_u[i, j+1] + temporary_v_u[i, j-1] - 4*temporary_v_u[i, j])
            v.v[i, j] = temporary_v[i, j] + c*(temporary_v[i+1, j] + temporary_v[i-1, j] + temporary_v[i, j+1] + temporary_v[i, j-1] - 4*temporary_v[i, j])
    return v

def main():
    nx, ny = 100, 100
    c = 0.1
    v = initialize_velocity_field(nx, ny)
    for i in range(1000):
        v = time_step(v, c)

elapsed_time = timeit.timeit(main, number=1)
print(f"Elapsed time: {elapsed_time:.2f} s")