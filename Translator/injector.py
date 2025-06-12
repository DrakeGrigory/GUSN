import numpy as np
#INJECTOR - adds an error in a single bit of array.
#Since my case is symetrical (X and O) it only injects in the 1/4 of the martix including middle row and collumn

#Test matrix
#arr1 = np.array([[0,1,0],
#                 [1,0,1],
#                 [0,1,0]])


def injector(arg_org,printResult):
    arr_len_half = (len(arg_org)>>1)+1
    units = arr_len_half * arr_len_half

    arr3D = np.zeros([units,len(arg_org),len(arg_org)],dtype=bool)
    for u in range(0, units):
        arr3D[u]=arg_org

    cnt=0
    for j_rows in range(0, arr_len_half):
        for i_colls in range(0, arr_len_half):
            arr3D[(cnt),j_rows,i_colls] = ~(arr3D[(cnt),j_rows,i_colls])
            cnt = cnt + 1

    if(printResult):
        print("\n Input matrix:\n" + str(arg_org) +"\n\nOutput of injector:\n" + str(arr3D))
    
    return arr3D

#Test call
#arr3D_2 = injector(arr1,1)
