import numpy as np
import functions as f



# Reference boolean matrices
matrices_org = [
    np.array([[1,0,1],[0,1,0],[1,0,1]], dtype=bool), #CROSS  (X)
    np.array([[0,1,0],[1,0,1],[0,1,0]], dtype=bool), #CIRCLE (O)
]

names = ["Cross ",
         "Circle"]
for i in range(0,2):
    #inject matrixes with error
    matrix_set = f.injector(matrices_org[i])

    #printing matrixes in CLI 
    matrix_set_with_org = np.insert(matrix_set, 0, matrices_org[i], axis=0)
    f.cli_printer(matrix_set_with_org,5,names[i])

