import pickle
import requests
import json
import os
from bs4 import BeautifulSoup
import urllib3.request

# urls=["https://www.erfan.ir/farsi/mafatih/index/1#firstpage", "https://www.erfan.ir/farsi/mafatih/index/2#firstpage", "https://www.erfan.ir/farsi/mafatih/index/3#firstpage"]
bab=0
data=[]
ticount=447

urls=[ "https://www.erfan.ir/farsi/mafatih/index/3#firstpage"]

for url in urls:
    html_page = urllib3.request.urlopen(url)
    soup = BeautifulSoup(html_page, "html.parser")
    tbl = soup.find('section', {'class': 'IntraContentMafatih w100p'})
    a=tbl.findAll('a')
    passed=0
    count=0
    indexbab=0
    indexbabidle=0

    bab=3
    listdivs=tbl.findAll('div')
    # listdivs2=listdivs[1:]
    for itr, row in enumerate(listdivs):
        classe=row["class"]

        if row.get_text()!='':
            # if not row
            link=a[itr-passed].get('href')
            indentDict={'mafatihtext':"1", "mafatihtext2":"2", "mafatihtext3":"3", "mafatihtext4":"4",'mafatihtitr':"titr",\
                "mafatihtextsound2":"2" , "mafatihtextsound":"1" }
            if indentDict[f"{classe[-1]}"]== "1":
                title=a[itr-passed].get('title')
                indexbab=indexbabidle
            # print(classe[-1])
            titleSearch=a[itr-passed].get('title')
            indexbabidle=indexbabidle+1


            try:

                url= f"https://www.erfan.ir{link}"
                Url=url.encode('ascii', 'ignore').decode('ascii')
                # print(type(Url))
                # break

                request = urreq.Request(f"{Url}")
                resp1 = urreq.urlopen(request)
                resp = resp1.read()
                soup = bs.BeautifulSoup(resp, 'html.parser')
                ArabTar = soup.findAll('section', {'class': 'js_MafatidText'}) #js_MafatidText MafatidText m0a table
                Title = str(soup.findAll('title'))
                Title = Title.replace('[<title>', '')
                Title = Title.replace('</title>]', '')
                Title = Title.replace('متن و ترجمه استاد انصاریان', '')
                Title = Title.replace('-- صوتی', '')
                Title = Title.replace(' -  - صوتی', '')
                Title = Title.replace('  - ', '')
                Title = Title.replace(' - ', '')

                Tozih=[]
                About = soup.findAll('section', {'class': 'js_MafatidText MafatidText m0a table'}) #js_MafatidText MafatidText m0a table
                for sec in About:
                    # tocount=tocount+1
                    # Tozih.update({tocount:sec.get_text()})
                    Tozih.append(sec.get_text())




                ticount=ticount+1

                data.append({'index': ticount , 'indexbab': indexbab , 'bab': bab , 'title' :titleSearch  , 'titleDetail' :title,'arabic': Tozih })

            except:
                print(f"{link}")


        else:
            passed=passed+1
            print(passed)
        # count=1+count
        # if count==50:
        #     break



dirDestination="G:\\Flutter\\Qurani2_Babs_SplitText\\python\\Babs"
dirFinal=f"{dirDestination}\\ListofJsonForSearchBab3.json"
with open(dirFinal, "w", encoding='utf8') as write_file:
    json.dump(data, write_file, ensure_ascii=False, indent=4)