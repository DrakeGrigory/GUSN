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

    if(matrices[0].shape[0]==3):
        space_val = [2,3,2,3]
    elif(matrices[0].shape[0]==5):
        space_val = [4,5,6,3]

    def spaces(num):
        sp = ""
        for i in range(0,num):
            sp += " "
        return sp
    
    for i in range(0, len(matrices), max_cols):
        group = matrices[i:i+max_cols]
        if(i == 0):
            header = spaces(space_val[0])+str(org_name)+spaces(space_val[1])+" ".join([spaces(space_val[2])+f"Matrix {i+j}" for (j) in range(1,len(group))])
        else:
            header = " ".join([spaces(space_val[0])+f"Matrix {i+j}"+spaces(space_val[3]) for (j) in range(0,len(group))])
        print(header) # Print each row of the group side by side
        
        for row_idx in range(group[0].shape[0]):
            line = ""
            for mat in group:
                line += spaces(2) 
                line += ''.join([WHITE if val else DARK_GREY for val in mat[row_idx]])
                line += spaces(4)
            print(line)
        print()


# ---------------------------- CLI_PRINTER ---------------------------- CLI_PRINTER ---------------------------- #
# -------------------------------------------------------------------------------------------------------------- #
#
#
#
# -------------------------------------------------------------------------------------------------------------- #
# -------------------------- DISPLAY_WEIGHTS -------------------- DISPLAY_WEIGHTS ------------------------------ #

# weights = np.array([
#     [1, 2, 3],
#     [4, 5, 6],
#     [7, 8, 9]
# ])


def display_weights(weights):
    COLOR_CODES = [
        '\033[48;5;81m',   #1 Blue
        '\033[48;5;82m',   #2 Green
        '\033[48;5;214m',  #3 Orange
        '\033[48;5;196m',  #4 Red
        '\033[48;5;226m',  #5 Yellow
        '\033[48;5;201m',  #6 Pink
        '\033[48;5;1m',    #7 Bordo 
        '\033[48;5;10m',   #8 Darker Green? 
        '\033[48;5;15m',   #9 Gray?
    ]
    RESET = '\033[0m'

    # Assign a color to each unique value
    unique_vals = np.unique(weights)
    #color_dict = {val: COLOR_CODES[i % len(COLOR_CODES)] for i, val in enumerate(unique_vals)}
    color_dict = {}
    for i, val in enumerate(unique_vals):
        color_dict[val] = COLOR_CODES[i % len(COLOR_CODES)]

    print("\nWeights of the matix:")

    rows, cols = weights.shape
    for i in range(rows):
        row = ""
        for j in range(cols):
            color = color_dict[weights[i, j]]
            row += f"{color} {weights[i, j]} {RESET}"
        print(row)
    print("")

# -------------------------- DISPLAY_WEIGHTS -------------------- DISPLAY_WEIGHTS ------------------------------ #
# -------------------------------------------------------------------------------------------------------------- #
#
#
#
# -------------------------------------------------------------------------------------------------------------- #
# --------------------------- SAVE_DATA_SET ------------------------- SAVE_DATA_SET ---------------------------- #

def save_data_set(matrix_set, mode, hex_filename="DataSet/data_set.hex"):
    #print(matrix_set)
    file_i = open(hex_filename, mode)

    for matrix in matrix_set:
        #print(matrix.shape)    
        bits=''
        for row in matrix:
            #print(f"row:{row}")
            bits += ''.join(['1' if x else '0' for x in row])
        
        str_to_hex = hex(int(bits, 2)) # convert int to a hex & convert string base2/binary to int
        hex_val_no0x= str_to_hex[2:]   # Remove '0x'
        hex_val = hex_val_no0x.upper() # uppercase
        #print(f"Bits: {bits}   str_to_hex {str_to_hex}   hex_val_no0x {hex_val_no0x}    hex_val{hex_val}")
        file_i.write(f"{hex_val}\n")
    file_i.close()
