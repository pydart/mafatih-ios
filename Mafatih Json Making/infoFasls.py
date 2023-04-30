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
    fasls= { " فصل اول تعقیبات مشترک":["https://bit.ly/3g7zTU2"," https://bit.ly/3efGtGt","https://bit.ly/2WU3tVn","https://bit.ly/3bQmdti","https://bit.ly/2ZvkHdM"],\
        "فصل دوم تعقیبات مختصه": ["https://bit.ly/2LXk1pb", "https://bit.ly/2ZtkS97","https://bit.ly/2yuaTpa","https://bit.ly/2WUHqht","https://bit.ly/36l54a6",\
            "https://bit.ly/2Tzg8eC","https://bit.ly/3d28AsA","https://bit.ly/2WVauph","https://bit.ly/3bYD1OK","https://bit.ly/3cWJvPC",\
              "https://bit.ly/3bQoftq" ,"https://bit.ly/3ehnM5j" , "https://bit.ly/3cVXRzJ","https://bit.ly/2LTHbx0","https://bit.ly/36zgLdv",\
                 "https://bit.ly/2zmIRMI", "https://bit.ly/3gey5bZ","https://bit.ly/2LSCgMA"],\
        "فصل سوم دعاهای ایام هفته‌ ": ["https://bit.ly/2WXokrc","https://bit.ly/2WSV3xy","https://bit.ly/2Ztm8sR","https://bit.ly/3bZt3N8","https://bit.ly/3bW9DJ4",\
            "https://bit.ly/3gf61oP","https://bit.ly/2WVpF1G"]
        } # fasl sevom bayad dirr mostaghim vared shavad vagarna error
    
    for fasl in fasls: #range(3,4)
        ticount=0
        data=[]

        for url in fasls[fasl]: #[ "فصل سوم دعاهای ایام هفته‌ "]:
            request = urreq.Request(url)
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

            ticount=ticount+1
            data.append({'index': ticount , 'title' :Title })


        Num=Num+1

        dirDestination="G:\\Flutter\\Qurani2\\python\\DailyDoa"
        filename=f"infoFasl{Num}"

        
        dirFinal=f"{dirDestination}\\{filename}.json"   #G:\\Flutter\\Qurani2\\python\\فصل سوم دعاهای ایام هفته‌
        with open(dirFinal, "w", encoding='utf8') as write_file:
            json.dump(data, write_file, ensure_ascii=False, indent=4)
        # break

save_sp500_tickers()

# a={1:["sds","rdfthg"], 2:["dfg"]}

# for aa in a:
#     for i in a[aa]:
#      print(i)