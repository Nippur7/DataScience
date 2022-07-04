import pandas as pd
import sys
df = pd.read_csv('C:/Users/tonym/OneDrive/Documentos/Henry/Data Science/DS-M3/Clase 01/Homework/Clientes.csv', sep=';')
#df
#NyA = df['Nombre_y_Apellido'].str.split(' ',-1,expand=True)
#NyA.info()
NyA = df['Nombre_y_Apellido'].str.split()
#NyA[3405][2]

type(NyA)

#df.info()
#NyA.iloc[:,[5]]
#ap55 = NyA.loc[:,5] == None
#ap55
#dfap5 = NyA.loc[ap55]
#dfap5.info()
apellidos = []
for i,j in enumerate(NyA):    
    #print(i,j[len(j)-1]) es la solucion
    for x in range(0,len(j)):
        sys.stdout.write(str(x)+'    ')
    print(' ')
    print(j)
    res = int(input('Contando de Izq a der y comenzando en 0 cual es la posicion del apellido?'))
    apellidos.append([i,j[res]])
    j.pop(res)
print(j)
print(apellidos)

    #for k in reversed(j):
        #type(k)
    #    print(k)
