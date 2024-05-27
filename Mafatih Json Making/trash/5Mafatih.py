import bs4 as bs
import pickle
import requests
import urllib.request as urreq
import json
import os

def save_sp500_tickers():

    # URLs=['https://www.erfan.ir/mafatih11/%D8%AF%D8%B9%D8%A7%DB%8C-%D8%B1%D9%88%D8%B2-%D8%B4%D9%86%D8%A8%D9%87-%DA%A9%D9%84%DB%8C%D8%A7%D8%AA-%D9%85%D9%81%D8%A7%D8%AA%DB%8C%D8%AD-%D8%A7%D9%84%D8%AC%D9%86%D8%A7%D9%86-%D8%A8%D8%A7-%D8%AA%D8%B1%D8%AC%D9%85%D9%87-%D8%A7%D8%B3%D8%AA%D8%A7%D8%AF-%D8%AD%D8%B3%DB%8C%D9%86-%D8%A7%D9%86%D8%B5%D8%A7%D8%B1%DB%8C%D8%A7%D9%86']
    Num=0

    # دعای روزها از شنبه تا جمعه
    URLs= ["https://bit.ly/3g7zTU2"]
    
   
    for url in URLs:
        request = urreq.Request(url)
        resp1 = urreq.urlopen(request)
        resp = resp1.read()
        soup = bs.BeautifulSoup(resp, 'html.parser')
        ArabTar = soup.findAll('section', {'class': 'js_MafatidText'}) #js_MafatidText MafatidText m0a table
        Title = str(soup.findAll('title'))
        Title = Title.replace('[<title>', '')
        Title = Title.replace('</title>]', '')



        Arabics={}
        Farsi={}
        About={}
        i=0
        arcount=0
        facount=0
        abcount=0
        sects=(str(ArabTar).split('article'))
        print(sects[1])
        break
        for sec in sects:
            row= sec.replace('<section class="js_MafatidText MafatidText m0a table">', '')
        #     # if '<' in row:
            row=row.replace('<', '')
            row=row.replace('>', '')
            row=row.replace('[', '')
            row=row.replace(']', '')
            row=row.replace('/section]', '')
            row=row.replace('/section', '')
            if row=='': row=[]

            if i % 2 == 0 :
                arcount=arcount+1
                Arabics.update({arcount:row})

            else:
                row = row.replace('class="js_TranslateText TranslateText Translate"', '')
                row = row.replace('/', '')
                facount=facount+1
                Farsi.update({facount:row})


            i=i+1

            
        Num=Num+1
        data={Num:{'number': Num , 'title' :Title , 'arabic': Arabics , 'farsi': Farsi}}
        # print(data)
        
        # print(Farsi)
        # my_json_string = json.dumps({'farsi' : Farsi, 'arabic' : Arabics}, ensure_ascii=False, indent=4).encode('utf8')
        # print(my_json_string.decode())
        #

        dirDestination="G:\\Flutter\\Qurani2\\python"
        filename=Num
        if not os.path.isdir('{}\\{}'.format(dirDestination,filename)):
            os.mkdir('{}\\{}'.format(dirDestination,filename))


        with open("{}\\{}.json".format(dirDestination,filename), "w", encoding='utf8') as write_file:
            json.dump(data, write_file, ensure_ascii=False, indent=4)


save_sp500_tickers()
