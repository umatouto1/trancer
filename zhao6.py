a=str(input()).strip()
a=a.lstrip('0') or '0'
a1=a[::-1].ljust(3,'0').lstrip('0') or '0'
print(a1)
for i in a1:
   print(int(i))

b=('Z','Y','X','W','V','U','T','S','R','Q','P','O','N','M','L','K','J','I','H','G','F','E','D','C','B','A')
c=input().strip()
e=[]

for i in c:

     if 'A'<=i<='Z':

        d=ord(i)-ord('A')

        e.append(b[d])

     else:

        e.append(i)

print(' '.join(e))