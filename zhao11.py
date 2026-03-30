import pandas as pd
import numpy as np
d=pd.date_range('2021-06-01',periods=6)
df=pd.DataFrame(np.random.randint(0,12,size=(6,4)),index=d,columns=list('ABCD'))
print(df)
# print(df[df.A>5])
# df.iloc[2,2]=114514
# df.loc['2021-06-01','B']=1919810
# print(df)
# df[df.A>5]=0
# print(df)
# df.loc[df['A']<2,'A']=1
# print(df)

df['F']=np.nan
print(df)
df['E']=np.arange(6)
print(df)
df['G']=np.linspace(0,10,6)
print(df)
df['H']=pd.Series([1,2,3,4,5,6],index=pd.date_range('2021-06-01',periods=6))
print(df)