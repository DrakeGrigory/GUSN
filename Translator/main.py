import numpy as np
import functions as fun

# Weights for the martix
weights = np.array([
    [1, 2, 1],
    [2, 3, 2],
    [1, 2, 1]
])

# Reference boolean matrices
matrices_org = [
    #np.array([[1,0,1],[0,1,0],[1,0,1]], dtype=bool), #CROSS  3x3 (X)
    #np.array([[0,1,0],[1,0,1],[0,1,0]], dtype=bool), #CIRCLE 3x3 (O)
    np.array([[1,0,0,0,1],[0,1,0,1,0],[0,0,1,0,0],[0,1,0,1,0],[1,0,0,0,1]]), #CROSS  5x5 (X) 
    np.array([[0,0,1,0,0],[0,1,0,1,0],[1,0,0,0,1],[0,1,0,1,0],[0,0,1,0,0]]) #CIRCLE 5x5 (O)
]

names = ["Cross ",
         "Circle"]
file_mode = ["w","a"]


fun.display_weights(weights)

for i in range(0,2):
    print(f"Set of: {names[i]}")

    #inject matrixes with error
    matrix_set = fun.injector(matrices_org[i])

    #printing matrixes in CLI 
    matrix_set_with_org = np.insert(matrix_set, 0, matrices_org[i], axis=0)
    fun.cli_printer(matrix_set_with_org,5,names[i])

    fun.save_data_set(matrix_set_with_org,file_mode[i])


