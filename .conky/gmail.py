# for Google Apps

import os

domain="yourdomain"
username="username"
password="password"

com="wget -q -O - https://mail.google.com/a/"+domain+"/feed/atom --http-user="+username+"@"+domain+" --http-password="+password+" --no-check-certificate"
temp=os.popen(com)
msg=temp.read()
index=msg.find("<fullcount>")
index2=msg.find("</fullcount>")
fc=int(msg[index+11:index2])
print(str(fc))
