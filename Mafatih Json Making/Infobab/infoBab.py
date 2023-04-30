import bs4 as bs
import pickle
import requests
import urllib.request as urreq
import json
import os



from bs4 import BeautifulSoup
import urllib.request

urls=["https://www.erfan.ir/farsi/mafatih/index/1#firstpage", "https://www.erfan.ir/farsi/mafatih/index/2#firstpage", "https://www.erfan.ir/farsi/mafatih/index/3#firstpage"]
bab=0

for url in urls:
    html_page = urllib.request.urlopen(url)
    soup = BeautifulSoup(html_page, "html.parser")
    tbl = soup.find('section', {'class': 'IntraContentMafatih w100p'})
    a=tbl.findAll('a')
    passed=0
    count=0
    ticount=0
    data=[]
    for itr, row in enumerate(tbl.findAll('div')):

        classe=row["class"]
        if row.get_text()!='':

            # if not row
            link=a[itr-passed].get('href')
            title=a[itr-passed].get('title')
            indentDict={'mafatihtext':"1", "mafatihtext2":"2", "mafatihtext3":"3", "mafatihtext4":"4",'mafatihtitr':"titr",\
                "mafatihtextsound2":"2" , "mafatihtextsound":"1" }


            ticount=ticount+1
            # print(classe[-1])

            data.append({'index': ticount , 'title' :title , 'link' :link, 'indent' :indentDict[f"{classe[-1]}"] })

            # print(title)
            # print(link)
            # print(classe)
            # print(row.has_attr('href'))

        else:
            passed=passed+1
            print(passed)
        # count=1+count
        # if count==50:
        #     break
                

    bab=bab+1

    dirDestination="G:\\Flutter\\Qurani2\\python\\Babs"
    filename=f"infobab{bab}"


    dirFinal=f"{dirDestination}\\{filename}.json"   #G:\\Flutter\\Qurani2\\python\\فصل سوم دعاهای ایام هفته‌
    with open(dirFinal, "w", encoding='utf8') as write_file:
        json.dump(data, write_file, ensure_ascii=False, indent=4)
    # break
