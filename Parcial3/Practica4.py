# -*- coding: utf-8 -*-
"""
Created on Tue Oct 21 13:32:02 2025

@author: lizal
"""
import cv2
import matplotlib.pyplot as plt
import numby as np
import random

#print ('JELOUUUUU')
l1=[]
l2=[]
for i in range(1,5):
    #print(random(1,100))
    l1.append(random.randint(1,100))
    l2.append(random.randint(1,100))
    
fig, ax = plt.subplot()
ax.plot(l1,l2)
fig.canvas.draw()
img = np.array(fig.canvas.buffer_rgba())
img= cv2.cvtColor(img,cv2.COLOR_RGBA2BGR)
cv2.imshow('Grafico',img)
cv2.waitKey(0)
cv2.destroyAllWindows