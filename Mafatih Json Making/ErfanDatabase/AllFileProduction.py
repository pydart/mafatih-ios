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
babcount=1
doaNum1=0
data1=[]
dataInfo1=[]

# listSec =[{"mafatihId":"4","mafatihSubject":"تعقیبات نماز عصر به نقل از مصباح المتهجد"}]
for jj, sec in enumerate (listSec):
    Arabics={}
    Farsi={}
    Tozih={}
    itr=0
    doaNum=int(sec["mafatihId"])
    mafatihid=sec["mafatihId"]
    bab=sec["mafatihBab"]

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

    txt= sec["mafatihText"]
    # print(txt)
    txtSplit1=txt.split("@@")

    for num, txtspli in enumerate(txtSplit1):
        itr=itr+1
        if "%%" in txtspli:
            txtSplit2=txtspli.split("%%")
            if (len(txtSplit2) % 2 != 0):
                Title = Title.replace(' - ', '')
                Tozih.update({itr:txtSplit2[1].replace('{/', '{').replace('/}', '}').replace('%%', '').replace('%', '').replace('@@', '').replace('@', '')})
                Arabics.update({itr:txtSplit2[2].replace('{/', '{').replace('/}', '}').replace('%%', '').replace('%', '').replace('@@', '').replace('@', '')})
            else:
                Tozih.update({itr:txtSplit2[0].replace('{/', '{').replace('/}', '}').replace('%%', '').replace('%', '').replace('@@', '').replace('@', '')})
                Arabics.update({itr:txtSplit2[1].replace('{/', '{').replace('/}', '}').replace('%%', '').replace('%', '').replace('@@', '').replace('@', '')})
            # for i in range(0, len(txtSplit2)):
            #     print(len(txtSplit2))
            #     print(txtSplit2[i])
            #     Tozih.update({num:txtSplit2[i]})
            #     Arabics.update({num:txtSplit2[i+1]})
        else:
            if (num % 2 == 0):
                Arabics.update({itr:txtspli.replace('{/', '{').replace('/}', '}').replace('%%', '').replace('%', '').replace('@@', '').replace('@', '')})
            else:
                itr=itr-1
                Farsi.update({itr:txtspli.replace('{/', '{').replace('/}', '}').replace('%%', '').replace('%', '').replace('@@', '').replace('@', '')})

    # if babcount!=bab:
    #     doaNum1=0
    #     doaNum2=0
    #     doaNum3=0
    #     babcount=bab       
        
    data1={doaNum:{'number': doaNum , 'bab': int(bab) ,'title' :Title ,  'arabic': Arabics , 'farsi': Farsi, 'tozih': Tozih , }}
    dirDestination=filelocation
    filename=f"{mafatihid}"
    dirr='{}\\{}'.format(dirDestination,"AllFiles")
    if not os.path.isdir(dirr):
        os.mkdir(dirr)
    dirFinal=f"{dirr}\\{filename}.json"   #G:\\Flutter\\Qurani2\\python\\فصل سوم دعاهای ایام هفته‌

    with open(dirFinal, "w", encoding='utf8') as write_file:
        json.dump(data1, write_file, ensure_ascii=False, indent=4)

