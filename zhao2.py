import numpy as np
a=np.random.random((3,3))
print(np.max(a,axis=0))#行
print(np.min(a,axis=0))
print(np.sum(a,axis=1))#列
print(np.sum(a,axis=0))
print(a)
b=np.arange(1,10).reshape((3,3))
print(b)
print(np.argmin(b))
print(np.argmax(b))
print(np.mean(b))#平均数axis=0 沿着列方向计算 =1 沿行
print(np.median(a))#中位数
print(np.average(b))#axis=
print(np.cumsum(b))#累加
print(np.diff(b))#两项差
print(np.sort(a))
print(np.nonzero(a))
print(a.T)#np.transpose(a)斜对角线对称
print(np.clip(b,3,7))
