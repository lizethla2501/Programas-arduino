import cv2
import matplotlib.pyplot as plt
import numpy as np
import serial
import json

lista = []
puerto  = serial.Serial("COM13",115200)

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
        if len(lista) > 5:
            lista.pop(0)
        fig, [ax , bx ,cx , dx] = plt.subplots(2,2, figsize=(10,4))

        ax = graf[0,0]
        bx = graf[0,1]
        cx = graf[1,0]
        dx = graf[1,1]       
        #grafico = ax.plot(lista , color = 'purple')
        #ax.set_ylim(0,500)
              
        grafico = ax.bar(range (len(lista)) , (lista))
        ax.set_ylim(0,500)
        
        for _grafico , _lista in zip(grafico, lista):
            ax.text(_grafico.get_x()+ _grafico.get_width()/2, # posicion x
                    _lista  +1,
                    str(_lista),
                    ha='center', va='bottom' , fontsize=10, color='black') # agregar texto  '''
            
        ax.set_xlabel('Sensores')
        ax.set_ylabel('Valores')
        ax.set_title('Grafico de la Barras AX')

         # grafico de pastel 
        bx.set_ylim(0,500)
        valornuevo = 500 - valor 
        bx.pie([valor,valornuevo], labels=["Potenciometro","Restante"], 
               autopct="%1.1f%%")
        bx.set_title('Grafico de pastel BX')

        cx.set_ylim(0,500)
        valornuevo = 500 - valor 
        cx.pie([valor,valornuevo], labels=["Potenciometro","Restante"], 
               autopct="%1.1f%%")
        cx.set_title('Grafico de pastel CX')

        grafico2 = dx.bar(range (len(lista)) , (lista))
        dx.set_ylim(0,500)
        
        for _grafico , _lista in zip(grafico, lista):
            dx.text(_grafico.get_x()+ _grafico.get_width()/2, # posicion x
                    _lista  +1,
                    str(_lista),
                    ha='center', va='bottom' , fontsize=10, color='black') # agregar texto  '''
            
        dx.set_xlabel('Sensores')
        dx.set_ylabel('Valores')
        dx.set_title('Grafico de la Barras dX')

        fig.canvas.draw()
        img = np.array(fig.canvas.buffer_rgba())
        img = cv2.cvtColor(img,cv2.COLOR_RGB2BGR)
        cv2.imshow("Grafico de barras",img)
        cv2.waitKey(1)
        plt.close(fig)

        if cv2.waitKey(25) & 0xFF == ord('a'):
            break
    
    except json.JSONDecodeError: # captura error JSON
        print('Error de JSON')
    except Exception as e: # captura error en variable e 
        print('Error:', e)
        break
puerto.close() # cerrar puerto serial
cv2.destroyAllWindows() # cerrar todas las ventanas de opencv
