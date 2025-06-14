import numpy as np

# ------------------------------ INJECTOR ------------------------------ INJECTOR ------------------------------ # 
#INJECTOR - adds an error in a single bit of array.
#Since my case is symetrical (X and O) it only injects in the 1/4 of the martix including middle row and collumn

#Test matrix
#arr1 = np.array([[0,1,0],
#                 [1,0,1],
#                 [0,1,0]])


def injector(arg_org,printResult=0):
    arr_len_half = (len(arg_org)>>1)+1 #get half length + middle row
    units = arr_len_half * arr_len_half #calculate ammount of injections

    arr3D = np.array(np.zeros([units,len(arg_org),len(arg_org)],dtype=bool)) #create an array for saving
    for u in range(0, units):
        arr3D[u]=arg_org

    cnt=0
    for j_rows in range(0, arr_len_half): #inject the data
        for i_colls in range(0, arr_len_half):
            arr3D[(cnt),j_rows,i_colls] = ~(arr3D[(cnt),j_rows,i_colls])
            cnt = cnt + 1

    if(printResult): #optional printing
        print("\n Input matrix:\n" + str(arg_org) +"\n\nOutput of injector:\n" + str(arr3D))
    
    return arr3D

#Test call
#arr3D_2 = injector(arr1,1)
# ------------------------------ INJECTOR ------------------------------ INJECTOR ------------------------------ #
# -------------------------------------------------------------------------------------------------------------- #
#
#
#
# -------------------------------------------------------------------------------------------------------------- #
# ---------------------------- CLI_PRINTER ---------------------------- CLI_PRINTER ---------------------------- #
def cli_printer(matrices,max_cols,org_name):
    BLACK        = '\033[40m  \033[0m'  # Black background, two spaces
    WHITE        = '\033[47m  \033[0m'  # White background, two spaces
    DARK_GREY    = '\033[48;5;235m  \033[0m'
    MEDIUM_GREY  = '\033[48;5;240m  \033[0m'
    LIGHT_GREY   = '\033[48;5;245m  \033[0m'
    BRIGHT_BLACK = '\033[100m  \033[0m'
    BLACK        = '\033[40m  \033[0m'

    def spaces(num):
        sp = ""
        for i in range(0,num):
            sp += " "
        return sp
    
    for i in range(0, len(matrices), max_cols):
        group = matrices[i:i+max_cols]
        header = spaces(2)+str(org_name)+spaces(2)+" ".join([spaces(3)+f"Matrix {i+j+1}" for (j) in range(1,len(group))])
        print(header) # Print each row of the group side by side
        
        for row_idx in range(group[0].shape[0]):
            line = ""
            for mat in group:
                line += spaces(2) 
                line += ''.join([WHITE if val else DARK_GREY for val in mat[row_idx]])
                line += spaces(4)
            print(line)
        print()




### -------------------------  MAIN -------------------------  ###