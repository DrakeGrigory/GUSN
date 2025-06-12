import numpy as np


#arr1 = np.array([[0,1,2],
#                  [3,4,5],
#                  [6,7,8]])

arr1 = np.array([[0,1,0],
                 [1,0,1],
                 [0,1,0]])

#
arr_len_half = (len(arr1)>>1)+1
units = arr_len_half * arr_len_half

arr3D = np.zeros([units,len(arr1),len(arr1)],dtype=bool)
for u in range(0, units):
    arr3D[u]=arr1
    print(arr3D[u])

print("len_cut: " + str(arr_len_half))
print(arr1)


cnt=0
for j_rows in range(0, arr_len_half):
    for i_colls in range(0, arr_len_half):
        arr3D[(cnt),j_rows,i_colls] = ~(arr3D[(cnt),j_rows,i_colls])
        cnt = cnt + 1


print("It executed "+str(cnt)+" times")
print("\nOutput of arr1:\n"); print(arr3D)        



def injector(arg_org):
    arr3D = np.zeros([units,len(arg_org),len(arg_org)],dtype=bool)
    for u in range(0, units):
        arr3D[u]=arg_org

    cnt=0
    for j_rows in range(0, arr_len_half):
        for i_colls in range(0, arr_len_half):
            arr3D[(cnt),j_rows,i_colls] = ~(arr3D[(cnt),j_rows,i_colls])
            cnt = cnt + 1

    return arr3D

arr3D_2 = injector(arr1)