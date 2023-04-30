import bs4 as bs
import urllib.request as urreq
import json
import os


for babcount in range(1,8):
    filelocation=os.getcwd()
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
    for i, url in enumerate(links[10:]):
        url = url.replace(" ","")
        Url=url.encode('ascii', 'ignore').decode('ascii')
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
        arcount=0
        facount=0
        tocount=0


        About = soup.findAll('article', {'class': 'AboutText'}) #js_MafatidText MafatidText m0a table
        # sects=(str(About)).split(",")
        for sec in About:
            tocount=tocount+1
            Tozih.update({tocount:sec.get_text()})

        Tar = soup.findAll('div', {'class': 'MyFaText'}) #js_MafatidText MafatidText m0a table
        for sec in Tar:
            facount=facount+1
            Farsi.update({facount:sec.get_text()})


        Arb = soup.findAll('div', {'class': 'MyArText'}) #js_MafatidText MafatidText m0a table
        for sec in Arb:
            arcount=arcount+1
            Arabics.update({arcount:sec.get_text()})

        # sects=(str(ArabTar).split('article'))

        # for sec in sects:
        #     row= sec.replace('<section class="js_MafatidText MafatidText m0a table">', '')
        #     row=row.replace('<', '')
        #     row=row.replace('>', '')
        #     row=row.replace('[', '')
        #     row=row.replace(']', '')
        #     row=row.replace('/section]', '')
        #     row=row.replace('/section', '')

        #     if  not "class" in row and row!=""and row!=" ":
        #         arcount=arcount+1
        #         Arabics.update({arcount:row})



        Num=i+1
        data={Num:{'number': Num ,'title' :Title ,  'arabic': Arabics , 'farsi': Farsi, 'tozih': Tozih , }}

        dirr=f"{filelocation}\\{babcount}"
        filename=f"{Num}"

        if not os.path.isdir(dirr):
            os.mkdir(dirr)
        
        dirFinal=f"{dirr}\\{filename}.json"
        with open(dirFinal, "w", encoding='utf8') as write_file:
            json.dump(data, write_file, ensure_ascii=False, indent=4)
            # # break


