import bs4 as bs
import pickle
import requests
import urllib.request as urreq
import json
import os

filelocation="G:\\Python\\AppsWithHj\\Mafatih\\ErfanDatabase\\"
# filelocation="F:\\"
filename="res"
dirr= f"{filelocation}\\{filename}.json"
f = open(dirr, "r", encoding='utf8')
listSec = json.load(f)
# f.close()

# fasl="من اسم فصل هستم"
faslcount=1
doaNum1=0
doaNum2=0
doaNum3=0
doaNum0=0
babcount=1
data1=[]
data2=[]
data3=[]
data0=[]

# listSec =[{"mafatihId":"4","mafatihSubject":"تعقیبات نماز عصر به نقل از مصباح المتهجد"}]
for jj, sec in enumerate (listSec):
    Arabics={}
    Farsi={}
    Tozih={}
    itr=0
    doaNum=int(sec["mafatihId"])
    bab=sec["mafatihBab"]
    # if babcount!=bab:
    #     doaNum1=0
    #     babcount=bab
    #     dirDestination="G:\\Python\\AppsWithHj\\Mafatih\\ErfanDatabase\\infobab\\"
    #     filename=f"infobab{babcount}"
    #     dirFinal=f"{dirDestination}\\{filename}.json"   #G:\\Flutter\\Qurani2\\python\\فصل سوم دعاهای ایام هفته‌
    #     with open(dirFinal, "w", encoding='utf8') as write_file:
    #         json.dump(data, write_file, ensure_ascii=False, indent=4)

        # data=[]

    Title=sec["mafatihSubject"]
    Title = Title.replace('[<title>', '')
    Title = Title.replace('</title>]', '')
    Title = Title.replace('متن و ترجمه استاد انصاریان', '')
    Title = Title.replace('-- صوتی', '')
    Title = Title.replace(' -  - صوتی', '')
    Title = Title.replace('  - ', '')
    Title = Title.replace(' - ', '')
    Title = Title.replace('به نقل از مصباح المتهجد', '')
    Title = Title.replace('به نقل از کتاب مصباح المتهجد', '')

    doaNum0=doaNum0+1
    data0.append({'index': doaNum , 'title' :Title , 'indent' :"1" })

    # if bab=="0":
    #     doaNum0=doaNum0+1
    #     data0.append({'index': doaNum0 , 'title' :Title , 'indent' :"1" })
    # elif bab =="1": 
    #     doaNum1=doaNum1+1
    #     data1.append({'index': doaNum1 , 'title' :Title , 'indent' :"1" })
    # elif bab =="2":
    #     doaNum2=doaNum2+1
    #     data2.append({'index': doaNum2 , 'title' :Title , 'indent' :"1" })
    # elif bab=="3":
    #     doaNum3=doaNum3+1
    #     data3.append({'index': doaNum3 , 'title' :Title , 'indent' :"1" })



for ba in range(1,2):
    # dat=[data0,data1,data2,data3]
    dat=[data0]
    dirDestination="G:\\Python\\AppsWithHj\\Mafatih\\ErfanDatabase\\infobab\\"
    filename=f"infobab{ba}"
    dirFinal=f"{dirDestination}\\{filename}.json"   #G:\\Flutter\\Qurani2\\python\\فصل سوم دعاهای ایام هفته‌
    with open(dirFinal, "w", encoding='utf8') as write_file:
        json.dump(dat[ba-1], write_file, ensure_ascii=False, indent=4)

        # break
