import bs4 as bs
import pickle
import requests
import urllib.request as urreq
import json
import os

def save_sp500_tickers():

    babcount=2
    filelocation="G:\\Flutter\\Qurani2 -Babs - Copy - Copy\\python\\Babs"
    filename=f"infobab{babcount}"
    dirr= f"{filelocation}\\{filename}.json"
    f = open(dirr, "r", encoding='utf8')
    listSec = json.load(f)
    links=[]
    for sec in listSec:
        ref=sec["link"]
        Ref= f"https://www.erfan.ir{ref}"
        links.append(Ref)

    Num=0
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

        Arabics={}
        Farsi={}
        Tozih={}
        i=0
        arcount=0
        facount=0
        tocount=0


        About = soup.findAll('section', {'class': 'js_MafatidText MafatidText m0a table'}) #js_MafatidText MafatidText m0a table
        # sects=(str(About)).split(",")
        for sec in About:
            tocount=tocount+1
            Tozih.update({tocount:sec.get_text()})

        Num=Num+1
        data={Num:{'number': Num , 'bab': babcount ,'title' :Title ,  'arabic': Tozih , }}

        dirDestination="G:\\Flutter\\Qurani2 -Babs - Copy - Copy\\python\\Babs\\withPrevNext"  
        filename=f"{Num}"

        # fasl= "فصل سوم دعاهای ایام هفته‌ "
        dirr='{}\\{}'.format(dirDestination,babcount)
        if not os.path.isdir(dirr):
            os.mkdir(dirr)
        
        dirFinal=f"{dirr}\\{filename}.json"   #G:\\Flutter\\Qurani2\\python\\فصل سوم دعاهای ایام هفته‌
        # print(dirDestination)
        # print(fasl)
        # break
        with open(dirFinal, "w", encoding='utf8') as write_file:
            json.dump(data, write_file, ensure_ascii=False, indent=4)
    # # break

# 



save_sp500_tickers()

