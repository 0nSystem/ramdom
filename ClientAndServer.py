#1.- Usando la libreria sockets y getopt crea un cliente y un servidor que primero puedan recibir y enviar mensajes
#
#2.- Quizas estaria bien echarlo un ojo despues a la libreria thread.
#
import socket
import getopt
import sys


class sock():
	def __init__(self,ip,port):
		self.__sock=socket.socket()
		self.__ip=ip
		self.__port=int(port)
		self.__buffer=2048
	def server(self):
		#Fijasr conexion
		self.__sock.bind((self.__ip,self.__port))
		#Modo escucha
		self.__sock.listen(3)
		while True:
			'''Aceptar conexiones
			conn se queda con la configuracion de socket que se conecta !!!!!!!Creando un nuevo objeto socket para enviar y recibir datos!!!!!!!
			addr con la tuple de ip y puerto
			'''
			conn,addr =self.__sock.accept()
			mensaje=conn.recv(1024).decode()
			print(mensaje)
			if mensaje=='exit':
				conn.close()
			
			
	def client(self):
		self.__sock.connect((self.__ip,self.__port))
		while True:
			__enviarMensage=input()
			#Codificar el mensaje
			self.__sock.send(__enviarMensage.encode())
			if __enviarMensage == 'exit':
					self.__sock.close()
					break
		pass
class main():
	def __init__(self):
		self.__help=('-m elegir modo client/server','-i para elegir la direccion ip', '-p para elegir el puerto','-h para solicitar ayuda')
		#getopt.getopt(), genera un tupla por eso [0] (a saber porque esta siempre vacia)
		self.__menu=getopt.getopt(sys.argv[1:],'m:i:p:h')
		
	def control(self):
		'''Permite establecer un flujo del programa
		i recibe la flag
		a recibe el dato del parametro'''
		for i,a in self.__menu[0]:
			if i == '-h':
				for i in self.__help:
					print(i)
				break
			elif i == '-m':
				self.__mode=a
			elif i == '-i':
				self.__ip=a
			elif i == '-p':
				self.__port=a
	def execute(self):
		'''Este metodo sirve para ejecutar la funcion despues de establecer el flujo del programa'''
		print(self.__mode,self.__ip,self.__port)
		if self.__mode == 'server':
			sock(self.__ip,self.__port).server()
		elif self.__mode == 'client':
			sock(self.__ip,self.__port).client()
			pass
		


		


a=main()
a.control()
a.execute()
