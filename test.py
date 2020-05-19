import requests
from bs4 import BeautifulSoup

url='https://www.qiushibaike.com/text/'

res=requests.get(url)
result=res.text


soup=BeautifulSoup(result,'html.parser')
list_joke=soup.find_all('div', class_="article block untagged mb15 typs_hot" )
for i in list_joke:
    authou=i.find('h2').text
    obj=i.find('div', class_="content").text
    score=i.find('span', class_="stats-vote").text
    comment=i.find('i', class_="number").text
    print('作者是:',authou.strip())
    print('内容如下:',obj.strip(),)
    print('有'+score+'觉得好笑','总共有'+comment+'人评论')