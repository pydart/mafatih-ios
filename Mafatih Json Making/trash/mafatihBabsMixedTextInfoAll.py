import bs4 as bs
import pickle
import requests
import urllib.request as urreq
import json
import os

def save_sp500_tickers():

    data=[]
    Num=0
    for babcount in range(1,4):
        
        filelocation="G:\\Flutter\\Qurani2\\python\\Babs"
        filename=f"infobab{babcount}"
        dirr= f"{filelocation}\\{filename}.json"
        f = open(dirr, "r", encoding='utf8')
        listSec = json.load(f)
        links=[]
        for sec in listSec:
            ref=sec["link"]
            Ref= f"https://www.erfan.ir{ref}"
            links.append(Ref)

        # print(links)


        
        Numbab=0
        for url in links: #[ "فصل سوم دعاهای ایام هفته‌ "]:

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

            Num=Num+1
            Numbab=Numbab+1
            data.append({'index': Num , 'indexbab': Numbab , 'bab': babcount , 'title' :Title ,'arabic': Tozih  })





    dirDestination="G:\\Flutter\\Qurani2 -Babs\\python\\Babs\\mixedText"
    filename="infobabMixedTextInfoAll"


    dirFinal=f"{dirDestination}\\{filename}.json"   #G:\\Flutter\\Qurani2\\python\\فصل سوم دعاهای ایام هفته‌
    with open(dirFinal, "w", encoding='utf8') as write_file:
        json.dump(data, write_file, ensure_ascii=False, indent=4)
    # break

    # 



save_sp500_tickers()

