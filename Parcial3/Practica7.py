# -*- coding: utf-8 -*-
"""
Created on Tue Oct 28 12:28:15 2025

@author: lizal
"""

import cv2
import matplotlib.pyplot as plt
import numpy as np
import serial
import json

lista = []
puerto  = serial.Serial("COM5",115200)

plt.ion() 

while True:
    try:
        linea = puerto.readline().decode().strip() # leer lo que envia el serial sin espacios 
        if not linea:
            continue

        objeto = json.loads(linea)
        print(objeto)
        valor = objeto['values'] 
        lista.append(valor)
        if len(lista) > 100:
            lista.pop(0)
        fig, ax = plt.subplots()
        grafico = ax.plot(lista , color = 'purple')
        ax.set_ylim(0,500)
        '''ax.set_title('liz')
        for grafico,ejesy in zip(grafico, ejesy):
            ax.text(grafico.get_x()+ grafico.get_width()/2, # posicion x
                    ejesy +1,
                    str(ejesy),
                    ha='center', va='bottom' , fontsize=10, color='black') # agregar texto  '''
        ax.set_xlabel('Sensores')
        ax.set_ylabel('Valores')
        ax.set_title('Grafico de barras con Opencv')
        fig.canvas.draw()
        img = np.array(fig.canvas.buffer_rgba())
        img = cv2.cvtColor(img,cv2.COLOR_RGB2BGR)
        cv2.imshow("Grafico de barras",img)
        cv2.waitKey(1)
        plt.close(fig)

        if cv2.waitKey(25) & 0xFF == ord('a'):
            puerto.close()
            break
    
    except json.JSONDecodeError: # captura error JSON
        print('Error de JSON')
    except Exception as e: # captura error en variable e 
        print('Error:', e)
        break
puerto.close() # cerrar puerto serial
cv2.destroyAllWindows() # cerrar todas las ventanas de opencv
