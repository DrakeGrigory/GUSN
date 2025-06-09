import numpy as np

# Example boolean matrices
matrices = [
    np.array([[1,0,1],[0,1,0],[1,0,1]], dtype=bool),
    np.array([[0,1,0],[1,0,1],[0,1,0]], dtype=bool),
    np.array([[1,1,0],[1,1,1],[0,1,1]], dtype=bool),
    np.array([[1,0,0],[0,0,0],[1,0,0]], dtype=bool),
]

# ANSI color codes
BLACK = '\033[40m  \033[0m'  # Black background, two spaces
WHITE = '\033[47m  \033[0m'  # White background, two spaces

for idx, img in enumerate(matrices):
    print(f"Matrix {idx+1}:")
    for row in img:
        print(''.join([WHITE if val else BLACK for val in row]))
    print()