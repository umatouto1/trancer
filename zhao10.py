import numpy as np
import pandas as pd
# s=pd.Series([1,2,3,4,5,6,np.nan])#大写s
# print(s)
d=pd.date_range('20260323', periods=6)
# print(d)
df=pd.DataFrame(np.random.randn(6,4),index=d,columns=[f'{c:^6s}' for c in 'ABCD'])
print(df)
# print(df.index)
# print(df.describe())
# print(df.columns)
# print(df.sort_index(axis=1,ascending=False))
# print(df.T)
# print(df.values)
#print(df.sort_values(by='C'))#【test    【test
                              #  train    test
                              #  test     train
                              #  train】=  train
print(df[df.columns[0]])
print(df.loc[:,df.columns[0]])# select by label
print(df.loc[:,df.columns[0:2]])
print(df.T[0:3])
print(df.loc['20260323',df.columns[0:2]])
print(df.iloc[3,:])# select by data
print(df.iloc[[0,2,4],1:3])