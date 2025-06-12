import numpy as np


arr = np.array([[0,1,2],
                  [3,4,5],
                  [6,7,8]])

#arr = np.array([[0,1,0],
#                 [1,0,1],
#                 [0,1,0]])

#
arr_size = (len(arr)>>1)+1


arr1=np.repeat(arr,4)
arr2=[arr,arr,arr,arr]
print("\n\n\n")
print(arr2)
print("\n\n\n")

print("len_cut: " + str(arr_size))
print(arr1)

cnt = 0
for j_rows in range(0, arr_size):
    for i_colls in range(0, arr_size):
        #if(arr1[i_colls] > 0):
        arr1[cnt,j_rows,i_colls] = 0xFF
        cnt = cnt + 1

print(arr1)        