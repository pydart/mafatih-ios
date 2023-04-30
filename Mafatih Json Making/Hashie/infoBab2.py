import urllib.request as urreq
import json
import os
from bs4 import BeautifulSoup
import urllib.request

urls=["https://www.erfan.ir/farsi/mafatih/index/5#firstpage","https://www.erfan.ir/farsi/mafatih/index/6#firstpage","https://www.erfan.ir/farsi/mafatih/index/7#firstpage","https://www.erfan.ir/farsi/mafatih/index/8#firstpage","https://www.erfan.ir/farsi/mafatih/index/9#firstpage","https://www.erfan.ir/farsi/mafatih/index/10#firstpage","https://www.erfan.ir/farsi/mafatih/index/11#firstpage",]

for i, url in enumerate(urls):
    html_page = urllib.request.urlopen(url)
    soup = BeautifulSoup(html_page, "html.parser")
    tbl = soup.find('section', {'class': 'ContentInternal p5'})
    a=tbl.findAll('a')
    passed=0
    count=0
    ticount=0
    data=[]
    # print(a)
    for itr, row in enumerate(a):
        if row.get_text()!='':
            link=a[itr-passed].get('href')
            title=a[itr-passed].get_text()
            ticount=ticount+1
            data.append({'index': ticount , 'title' :title , 'link' :link })
            
        else:
            passed=passed+1
            print(passed)

    bab=i+1
    dirDestination=os.getcwd()
    filename=f"infobab{bab}"
    dirFinal=f"{dirDestination}\\{filename}.json" 
    with open(dirFinal, "w", encoding='utf8') as write_file:
        json.dump(data, write_file, ensure_ascii=False, indent=4)