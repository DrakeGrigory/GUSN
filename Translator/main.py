import matplotlib.image as mpimg
import matplotlib.pyplot as plt
import matplotlib.patches as ptch
import numpy as np

img = np.array([[1,0,1],  [0,1,0],  [1,0,1]], dtype=bool)
print(img)


fig, ax = plt.subplots()

plt.imshow(img, #source image 
           cmap='gray', #ensures black and white coloring
           interpolation='nearest') #keeps sharp pixel edges
plt.axis('off') #disable axis

rows, cols = img.shape
border = ptch.Rectangle(
        (0-0.5, 0-0.5),
         cols,rows,        #image size
         edgecolor='black',  #border color
         linewidth=1,      #border width
         facecolor='none') #transparent inside

ax.add_patch(border)
plt.show()

# Save and show an image
#plt.savefig("Translator/img1.png",dpi=1,bbox_inches='tight', pad_inches=0)
