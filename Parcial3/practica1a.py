import serial
import time

from tkinter import *
from tkinter import messagebox  


class Principal():
    def __init__(self):
            self.ven = Tk()
            self.ven.geometry("400x200")
            self.ven.title("SERIAL")
            self.ven.config(bg="lightblue")
            self.ven.eval('tk::PlaceWindow . center')

            self.conexion = None
            


    def recibir(self):
        try:
                conexion=serial.Serial('COM10',115200,timeout=1)
                messagebox.showinfo("EXITO", "SI FUNCIONO")

                while(True):
                    datos = conexion.readline().strip()
                    if datos != "": 
                        self.mensaje
                        (datos)
                    n += 1 
                    if n > 100:
                        break
                    time.sleep(0.1)

        except:
                 messagebox.showError("ERROR","ERROR CONEX")        
       
    
    def inicio(self):
        self.mensaje = Label(self.ven,text="HELLO")
        self.mensaje.pack(X = 10, Y = 10)
        Button(self.ven, text="ACEPTAR", command=self.recibir).place(X = 10, Y = 20)
        self.ven.mainloop()




if __name__== '__main__':
    app = Principal()
    app.inicio()
    app.conexion.close()