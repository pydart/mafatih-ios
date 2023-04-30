# import bs4 as bs
import pickle
import requests
import urllib.request as urreq
import json
import os
def save_sp500_tickers():

    data=[]
    Num=0
    for babcount in range(1,4):
        
        filelocation="G:\Flutter\Mafatih\Qurani2_Babs_SplitText_version6_Final_TargetSDK29\python\Babs"
        filename=f"{babcount}"
        dirr= f"{filelocation}\\{filename}"

        files= os.listdir(f'{dirr}')
        # print(files[0])
        # break
        
        for fil in files:
            dirFinal=f"{dirr}\\{fil}"   #G:\\Flutter\\Qurani2\\python\\فصل سوم دعاهای ایام هفته‌
            f = open(dirFinal, "r", encoding='utf8')
            data = json.load(f)
            print(fil)
            filen=fil[:-5]
            Title = data[filen]["title"]
            title = Title.replace('به نقل از مصباح المتهجد', '')
            data[filen]["title"]=title
            with open(dirFinal, "w", encoding='utf8') as write_file:
                json.dump(data, write_file, ensure_ascii=False, indent=4)
        # break

        # 



save_sp500_tickers()

