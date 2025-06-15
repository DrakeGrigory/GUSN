import numpy as np

def save_matrix_set_as_hex(matrix_set, hex_filename="../DataSet/data_set.hex"):
    #print(matrix_set)

    with open(hex_filename, "w") as file_i:

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


#matrix_set = np.random.choice([0, 1], size=(5, 3, 3)).astype(bool)
#save_matrix_set_as_hex(matrix_set)