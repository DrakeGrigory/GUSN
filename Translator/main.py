import matplotlib.image as mpimg
import matplotlib.pyplot as plt

path = "Images/Cross.bmp"
img = mpimg.imread(path)

plt.imshow(img)
plt.axis('off')  
plt.show()      