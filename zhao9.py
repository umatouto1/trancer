import numpy as np
a=np.arange(12).reshape(3,4)
print(np.split(a,2,axis=1))
print(np.array_split(a,3,axis=1))#不等量分割
print(np.vsplit(a,3))
print(np.hsplit(a,2))

b=a.copy()#deep copy 无法变动
a[2,0]=3
print(a)
print(b)