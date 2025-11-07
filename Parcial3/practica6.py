import cv2
import matplotlib.pyplot as plt
import numpy as np
import serial
import json

puerto  = serial.Serial("COM5",115200)

plt.ion() 

while True:
    try:
        linea = puerto.readline().decode().strip() # leer lo que envia el serial sin espacios 
        if not linea:
            continue

        objeto = json.loads(linea)
        print(objeto)
        ejesx = objeto['labels'] # etiquetas eje x
        ejesy = objeto['values'] # valores eje y
        fig, ax = plt.subplots()

        grafico = ax.bar(ejesx,ejesy , color = 'purple')
        ax.set_xlabel('Ejes X')
        ax.set_ylabel('Ejes Y')
        ax.set_title('Grafico de barras con Opencv')
        for grafico,ejesy in zip(grafico, ejesy):
            ax.text(grafico.get_x()+ grafico.get_width()/2, # posicion x
                    ejesy +1,
                    str(ejesy),
                    ha='center', va='bottom' , fontsize=10, color='black') # agregar texto
        fig.canvas.draw()
        img = np.array(fig.canvas.buffer_rgba())
        img = cv2.cvtColor(img,cv2.COLOR_RGB2BGR)
        cv2.imshow("Grafico de barras",img)
        cv2.waitKey(1)
        plt.close(fig)

        if cv2.waitKey(25) & 0xFF == ord('q'):
            puerto.close()
            break
    
    except json.JSONDecodeError: # captura error JSON
        print('Error de JSON')
    except Exception as e: # captura error en variable e 
        print('Error:', e)
        break
puerto.close() # cerrar puerto serial
cv2.destroyAllWindows() # cerrar todas las ventanas de opencv
