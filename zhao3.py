x=list(range(10))
print(x[-4:])
y=x[:]
print(id(y[0])==id(x[0]))
x1=[1,2,3,2,3]
print(x1)
print(x1.remove(2))
print(x1)
print(x1.pop())#末尾的元素删除
print(x1)
print(':'.join('abcdefg'.split('cd')))
print('apple.peach,banana,pear'.find('p') )
print(','.join('a b ccc\n\n\nddd '.split()))
print('Hello world'.upper())
a=(3),
print(a*3)
b=list(range(10))
del b[::2]
print(b)