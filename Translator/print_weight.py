import numpy as np

# weights = np.array([
#     [1, 2, 1],
#     [2, 3, 2],
#     [1, 2, 1]
# ])


weights = np.array([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
])


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


    rows, cols = weights.shape
    for i in range(rows):
        row = ""
        for j in range(cols):
            color = color_dict[weights[i, j]]
            row += f"{color} {weights[i, j]} {RESET}"
        print(row)
