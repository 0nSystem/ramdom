#/usr/bin/python3.8
import tkinter,tkinter.filedialog,os
#mejora, ajustar importacion Tk,label,button,os.system

#Utilidades
class utils():
	def __init__(self):
		self.home="~/"
		self.nombre_archivo_final="archivo_exiftool.txt"
		self.ruta_final=self.home+self.nombre_archivo_final

	def explorador_archivos(self):
		self.archivo=tkinter.filedialog.askopenfilename(title="Explorador de archivos",
			filetypes=(("Ficheros de Texto", "*.txt"),("Todos los archivos","*.*")))
	def analisis_simple(self):
		self.analisis_s="exiftool "+self.archivo+" > "+self.ruta_final
		os.system(self.analisis_s)
	def eliminar_metadatos(self):
		self.borrar_meta="exiftool -all= "+self.ruta_final
		os.system(self.borrar_meta)
		os.system(self.analisis_s)
	def mostrar_resultado(self):
		self.mostrar="gedit "+self.ruta_final
		self.borrar_archivo="rm "+self.ruta_final
		os.system(self.mostrar)
		os.system(self.borrar_archivo)

#gui
class gui(utils):
	def __init__(self):
		self.window=tkinter.Tk()
		self.window.geometry("400x400")
		self.window.title("GUI Exiftool")
		#construccion clase utils
		self.herramienta=utils()

	def frame1(self):
		self.frame_gui=tkinter.Frame(self.window).pack()
		self.label1=tkinter.Label(self.frame_gui,text="Bienvenido").pack()
		self.label2=tkinter.Label(self.frame_gui,text="1.-Primero abrir el explorador y seleccionar un archivo").pack(pady=10)
		self.label3=tkinter.Label(self.frame_gui,text="2.-A continuacion elige una opcion de las mostradas    ").pack()


	def frame2(self):
		def salir():
			self.window.destroy()

		self.frame_botones=tkinter.Frame(self.window).pack(pady=20)
		tkinter.Button(self.frame_botones,text="Explorador de Archivos",command=self.herramienta.explorador_archivos,width=20,height=2,bg="black",fg="red").pack()
		tkinter.Button(self.frame_botones,text="Analisis Simple",command=self.herramienta.analisis_simple,width=20,height=2,bg="black",fg="red").pack()
		tkinter.Button(self.frame_botones,text="Eliminar Metadatos",command=self.herramienta.eliminar_metadatos,width=20,height=2,bg="black",fg="red").pack()
		tkinter.Button(self.frame_botones,text="Mostrar Resultado",command=self.herramienta.mostrar_resultado,width=20,height=2,bg="black",fg="red").pack()
		tkinter.Button(self.frame_botones,text="Salir",command=salir,width=20,height=2,bg="black",fg="red").pack()
	def retorno_gui(self):
		self.window.mainloop()



#Main
ventana=gui()
ventana.frame1()
ventana.frame2()

ventana.retorno_gui()