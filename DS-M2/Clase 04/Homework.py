import numpy as np # importando numpy
from scipy import stats # importando scipy.stats
import pandas as pd
import matplotlib.pyplot as plt # importando matplotlib
import seaborn as sns # importando seaborn

muestra = np.array( [[1.85, 1.80, 1.8 , 1.8],
       [1.73,  1.7, 1.75, 1.76],
       [ 1.65, 1.69,  1.67 ,  1.6],
       [1.54,  1.57, 1.58, 1.59],
       [ 1.4 , 1.42,  1.45, 1.48]]) 
print(muestra)
# Media

print(muestra.mean())

print(np.mean(muestra))

# Mediana

print(np.median(muestra))

# Moda

print(stats.mode(muestra[0]))

# Varianza

print(np.var(muestra))

# Desvío Estándar

print(np.std(muestra))

# Dibujamos el histograma. Notamos que no tiene distribución normal.
muestra = [1.85, 1.80, 1.8 , 1.8, 1.73,  1.7, 1.75, 1.76, 1.65, 1.69,  1.67 ,  1.6, 1.54,  1.57, 1.58, 1.59, 1.4 , 1.42,  1.45, 1.48]

frecuencias, extremos = np.histogram(muestra, bins=5)
print(frecuencias, extremos)


plt.hist(x=muestra, bins=5, color='#F2AB6D', rwidth=0.85)
plt.title('Histograma de altura')
plt.xlabel('Edades')
plt.ylabel('Frecuencia')
plt.show() 

# Utilizamos pandas para describir la muestra

muestra = np.array( [[1.85, 1.80, 1.8 , 1.8],
       [1.73,  1.7, 1.75, 1.76],
       [ 1.65, 1.69,  1.67 ,  1.6],
       [1.54,  1.57, 1.58, 1.59],
       [ 1.4 , 1.42,  1.45, 1.48]]) 

dataframe = pd.DataFrame(muestra, index=range(1,6), 
                        columns=['col1','col2','col3','col4'])
dataframe.describe()

grupos = np.array(  [[10.5, 17],
                    [6.8,18], 
                    [20.7,21], 
                    [18.2,16], 
                    [8.6,16], 
                    [25.8,21], 
                    [22.2,16],
                    [5.9,14], 
                    [7.6,18], 
                    [11.8,18]])


grupos_df = pd.DataFrame(grupos, index=range(1,11),columns=['Ingreso en miles','Años de estudio'])
print(grupos_df)
print(grupos_df.describe())

plt.hist(x=grupos_df[['Ingreso en miles']], bins=6, color='#F2AB6D', rwidth=0.85)
plt.title('Histograma de Ingresos')
plt.xlabel('Ingresos')
plt.ylabel('Frecuencia')
plt.show() 


plt.hist(x=grupos_df[['Años de estudio']], bins=6, color='#F2AB6D', rwidth=0.85)
plt.title('Histograma de Años de estudio')
plt.xlabel('Años de estudio')
plt.ylabel('Frecuencia')
plt.show() 

grupos_df.loc[11]=[ 50, 35 ]
print(grupos_df)

print(grupos_df.describe())

grupos_df.loc[12]=[ 120, 30 ]


print(grupos_df.describe())

print(grupos_df[['Ingreso en miles']].mean())

print(np.mean(grupos[0]))

diferencia = grupos_df[['Ingreso en miles']].mean() - np.mean(grupos[0])
print(diferencia)

# El resultado indica que la media se ve afectada por los valores extremos