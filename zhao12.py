import pandas as pd
import numpy as np

##fillna
# d=pd.date_range('2021-06-01',periods=6)
# df=pd.DataFrame(np.random.randint(0,12,size=(6,4)),index=d,columns=list('ABCD'))
# print(df)
# df.iloc[0,3]=np.nan
# df.iloc[1,2]=np.nan
# print(df)
# print(np.sum(df.isnull()==True))
# print(df.isnull().any(axis=0))
# print(df.fillna(value=0))#填充

##concatenating
# df1=pd.DataFrame(np.ones((3,3))*0,columns=['A','B','C'])
# df2=pd.DataFrame(np.ones((3,3))*1,columns=['A','B','C'])
# df3=pd.DataFrame(np.ones((3,3))*2,columns=['A','B','C'])
# print(df1)
# print(df2)
# print(df3)
# x=pd.concat([df1,df2,df3],axis=0,ignore_index=True)# 避免行标签重复，重新排序
# print(x)

##join['inner','outer']
df4=pd.DataFrame(np.ones((3,3)),columns=['a','b','c'],index=[1,2,3])
df5=pd.DataFrame(np.ones((3,3)),columns=['b','c','d'],index=[2,3,4])
# print(pd.concat([df4,df5],join='outer'))#默认outer处理
# print(pd.concat([df4,df5],join='inner',ignore_index=True))
# df=df4.reindex(df5.index)
# print(pd.concat([df,df5],axis=1))
# print(pd.concat([df4,df5],axis=1))