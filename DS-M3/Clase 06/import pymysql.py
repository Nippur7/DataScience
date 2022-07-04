import pymysql
import pandas as pd

conexion = pymysql.connect(host='localhost',
                                database='henry_m3',
                                user='root',
                                password='')

cursor = conexion.cursor()
cursor.execute("SELECT * FROM venta")
#for venta in cursor:
#    print(venta)
print(cursor)
Tventa = pd.read_sql_query('SELECT * FROM venta',conexion)
Tventa



#sqlEngine       = create_engine('://root:@localhost', pool_recycle=3600)

#dbConnection    = sqlEngine.connect()

#frame           = pd.read_sql("select * from test.uservitals", dbConnection);

 

#pd.set_option('display.expand_frame_repr', False)

#print(frame)

 
conexion.close()
#dbConnection.close()