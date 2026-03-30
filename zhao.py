#python学习 字符串的拼接与截取
name='alice'
green='hello'
print(green+' '+name)

fuck=100.0
me=200.5
print(str(fuck)+' '+str(me))
print(type(fuck+me))
print('fuck'+' '+'me')
print('fuck'*2)
print(fuck/4)

shit='fuckyou'
greeting='i want'
print(greeting+' '+(shit[2]+shit[5]+shit[2:4])*5)
#计算运算符
print(15%2,end=' ')
print(15//4,end=' ')
print(2**4)
#比较运算符
a=2.0
b=5.0
print('a>b:',a>b)
print('a!=b:',a!=b)
#赋值运算符
a=1
a+=1
print(a)
a%=2
print(a)
a**=2
print(a)
#逻辑运算符 and or not
print(a==0 and b==2)
print(a==0 or b==2)
print(not b==2)
print(not a==0)
print(1 and 1)
print(1 or 0)
print(not 1)
#成员运算符
ass='hello world'
hole='fuck'
c='c'
d='d'
print(hole in ass)
print(c in ass)
print(d in ass)
print(c not in ass)
#复合数据类型
list1=['吊','傻逼','弱智','唐人','废物']
tuple1=('吊','傻逼','弱智','唐人','废物')#元组不可修改
dic={'吊':'1','傻逼':'2','弱智':'3','唐人':'4','废物':'5'}#key=sole
print(dic['吊'])#key error=1
print(list[1:4])
print(dic)
set0={1,2,3,4,5,6,7,True}#不允许重复元素
print(set0)
list2=[1,2,3,4,5,5,'fuck']
list3=[4,3,6.8,'ass']
print(list2+list3)#dict can not plus dict
#成员运算符
b=1
if b in list2:
    b+=1
print(b)
while b in list2:
    b+=1
if b>=5:
    print(b)
c='uc'
print(c in list2)
list4=[1,2,3,4,5,5,'fuck',['NM',4]]#创建子列表
d=['NM',4]#讲究顺序
print(d in list4)





