#/usr/bin/python3.8
#
#Hacer un programa que primero lea por input "crear,modificar,borrar,ver" usuario (con tres campos nombre,Ciudad, Numero)
#A
#Nada con datos persistente de momento
#
#
import cmd
class shell(cmd.Cmd):
    def __init__(self):
        cmd.Cmd.prompt='CRUD-SHELL--> '
        cmd.Cmd.intro='\n\n\t\tBienvenido a un prototipo del CRUD-SHELL de OnSystem\n\n'
        super().__init__()
        self.__nombre=[]
        self.__ciudad=[]
        self.__numero=[]
    def do_new(self,args):
        self.__flags=str(args).split(" ")
        if len(self.__flags) == 3:
            self.__nombre.append(self.__flags[0])
            self.__ciudad.append(self.__flags[1])
            self.__numero.append(self.__flags[2])
        else:
            print("\n\tNecesitas escribir tres campos:\n\t\tnombre\n\t\tciudad\n\t\tnumero\n")
    def do_update(self,args):
        self.__flags=str(args).split(" ")

        #Tambien elegir el campo a modificar
        #Nombre usuario campo cambio
        #marcar campo
        if self.__flags[0]=='name':
            #Contador de indice por el nombre dicho
            for i in range(len(self.__nombre)):
                if self.__flags[1]==self.__nombre[i]:
                    #Aqui i ya contiene el indice para llamar a la posicion del resto de arrays
                    #habria que hacer el cambio de campo
                    if self.__flags[2]=='name':
                        self.__nombre.insert(i,self.__flags[3])
                    elif self.__flags[2]=='city':
                        self.__ciudad.insert(i,self.__flags[3])
                    elif self.__flags[2]=='numero':
                        self.__numero.insert(i,self.__flags[4])
                    else:
                        print('\n\n\tRevisa los campos seleccionados para modificar:\n\t\tname\n\t\tcity\n\t\tnumero')
        else:
            print("\n\tDeberias escribir la flag name\n")
        pass
    def do_delete(self,args):
        '''Funcion delete
        update name <nombre_usuario>
        '''
        self.__flags=str(args).split(" ")
        if len(self.__flags) == 2:
            if self.__flags[0] == 'name':
                for i in range(len(self.__nombre)):
                    if self.__nombre[i] == self.__flags[1]:
                        self.__nombre.pop(i)
                        self.__ciudad.pop(i)
                        self.__numero.pop(i)
                    else:
                        print("\n\tnose pudo borrar el usuario\n")
        else:
            print("\n\tNecesitas escribir name seguido del nombre de usuario que deseas borrar\n")
    def do_show(self,args):
        self.__flags=str(args).split(" ")
        print("Nombre,Ciudad,Numero")
        #opcion show all para ver todo
        if len(self.__flags) == 1 and self.__flags[0] == 'all':
            for i in range(0,len(self.__nombre),1):
                print(self.__nombre[i],self.__ciudad[i],self.__numero[i])
        #opcion show name para ver los datos de un usuario en concreto por nombre
        elif len(self.__flags) == 2 and self.__flags[0] == 'name':
            for i in range(0,len(self.__nombre),1):
                if self.__nombre[i] == self.__flags[1]:
                    print(self.__nombre[i],self.__ciudad[i],self.__numero[i])
        else:
            print("Las opciones son:\n\tall\n\tname 'name user'")
    
    def do_exit(self,args):
        exit()
        pass
        

shell().cmdloop()