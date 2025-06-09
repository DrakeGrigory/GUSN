import numpy as np

def spaces(num):
    sp = ""
    for i in range(0,num):
        sp += " "

    return sp



# Example boolean matrices
matrices = [
    np.array([[1,0,1],[0,1,0],[1,0,1]], dtype=bool), #CROSS  (X)
    np.array([[0,1,0],[1,0,1],[0,1,0]], dtype=bool), #CIRCLE (O)
    np.array([[1,1,0],[1,0,1],[0,1,0]], dtype=bool), #0_1
    np.array([[0,0,0],[1,0,1],[0,1,0]], dtype=bool), #0_2
    np.array([[0,1,1],[1,0,1],[0,1,0]], dtype=bool), #0_3
]

# ANSI color codes
BLACK        = '\033[40m  \033[0m'  # Black background, two spaces
WHITE        = '\033[47m  \033[0m'  # White background, two spaces
DARK_GREY    = '\033[48;5;235m  \033[0m'
MEDIUM_GREY  = '\033[48;5;240m  \033[0m'
LIGHT_GREY   = '\033[48;5;245m  \033[0m'
BRIGHT_BLACK = '\033[100m  \033[0m'
BLACK        = '\033[40m  \033[0m'

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


