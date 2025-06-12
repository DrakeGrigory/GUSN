import numpy as np

### -------------------  ANSI COLOR CODES -------------------  ###
BLACK        = '\033[40m  \033[0m'  # Black background, two spaces
WHITE        = '\033[47m  \033[0m'  # White background, two spaces
DARK_GREY    = '\033[48;5;235m  \033[0m'
MEDIUM_GREY  = '\033[48;5;240m  \033[0m'
LIGHT_GREY   = '\033[48;5;245m  \033[0m'
BRIGHT_BLACK = '\033[100m  \033[0m'
BLACK        = '\033[40m  \033[0m'

### -----------------------  FUNCTION -----------------------  ###
def spaces(num):
    sp = ""
    for i in range(0,num):
        sp += " "
    return sp

### -------------------------  MAIN -------------------------  ###


# Example boolean matrices
matrices = [
    np.array([[1,0,1],[0,1,0],[1,0,1]], dtype=bool), #CROSS  (X)
    np.array([[0,1,0],[1,0,1],[0,1,0]], dtype=bool), #CIRCLE (O)
    np.array([[1,1,0],[1,0,1],[0,1,0]], dtype=bool), #0_1
    np.array([[0,0,0],[1,0,1],[0,1,0]], dtype=bool), #0_2
    np.array([[0,1,1],[1,0,1],[0,1,0]], dtype=bool), #0_3
    np.array([[0,1,0],[0,0,1],[0,1,0]], dtype=bool)  #0_4
]

circle_ref = np.array([[0,1,2],
                       [3,4,5],
                       [6,7,8]])

#HOW DO I ACCESS?
#print(len(circle_ref[0:,0])) #0,1,2 
#print(len(circle_ref[0]))    #0,3,6
#arr_save = np.zeros([3,3,3],dtype=int)

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
 

print(arr1_size)
print(arr1)
for i_colls in range(0, len(arr1)):
    if(arr1[i_colls] > 0):
        arr1[i_colls] = 0xFF
print(arr1)


max_cols = 5  # max matrices per row
for i in range(0, len(matrices), max_cols):
    group = matrices[i:i+max_cols]
    # Print matrix numbers above
    header = "   ".join([f" Matrix {i+j+1}" for j in range(len(group))])
    print(header)
    # Print each row of the group side by side
    for row_idx in range(group[0].shape[0]):
        line = ""
        for mat in group:
            line += spaces(2) 
            line += ''.join([WHITE if val else DARK_GREY for val in mat[row_idx]])
            line += spaces(4)
        print(line)
    print()


