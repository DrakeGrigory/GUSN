
circle_ref = np.array([[0,1,2],
                       [3,4,5],
                       [6,7,8]])

#HOW DO I ACCESS?
# print(len(circle_ref[0:,0])) #0,1,2 
# print(len(circle_ref[0]))    #0,3,6
# arr_save = np.zeros([3,3,3],dtype=int)
# arr_save[2,2,1] = 9 (unit, row, column)

#for j_rows in range(0, len(circle_ref)):
arr1 = [10,0,30]
arr1_size = (len(arr1)>>1)+1
arr_save = np.zeros([3,3,3],dtype=int)
arr_save[0] = arr_save[0] +1
arr_save[1] = arr_save[1] +2
arr_save[2] = arr_save[2] +3
arr_save[2,2,1] = 9
print(arr_save)
print(arr_save[1])