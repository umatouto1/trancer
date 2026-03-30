import pandas as pd
import numpy as np

##merge
df1=pd.DataFrame(np.random.randint(0,12,size=(4,4)),columns=['a','b','c','d'])
print(df1)
df2=pd.DataFrame(np.random.randint(0,12,size=(4,4)),columns=['b','c','d','e'])
print(df2)
# print(pd.merge(df1,df2,on='c',how='outer'))# 默认inner ['left','right','inner','outer']
# print(pd.merge(df1,df2,on=['c','d'],how='left'))
# print(pd.merge(df1,df2,on=['c','d'],how='right'))
#indicator
# print(pd.merge(df1,df2,on='c',how='outer',indicator='indicator_columns'))
# print(pd.merge(df1,df2,left_index=True,right_index=True,how='outer'))
#suffixes
print(pd.merge(df1,df2,on='d',how='outer',suffixes=('_1_left','_2_right')))
