import json
import os
from natsort import natsorted # pip install natsort

ListSearch=[]

for i in range(0,12):
    babcount=i
    filelocation=f"G:\\Python\\AppsWithHj\\Mafatih\\ErfanDatabase\\{babcount}"

    listFiles = natsorted(os.listdir(filelocation))  # dir is your directory path
    number_files = len(listFiles)

    for num, onefile in enumerate(listFiles):

        dirr= f"{filelocation}\\{onefile}"
        # print(dirr)
        f = open(dirr, "r", encoding='utf8')
        fileRead = json.load(f)
        print(onefile[:-5])
        if num<number_files-2:
            fileFinal=fileRead[f"{int(onefile[:-5])+1}"]


            fileFinal["indexbab"] =int(onefile[:-5])
            fileFinal["bab"] =babcount

            ListSearch.append(fileFinal)


dirDestination="G:\\Python\\AppsWithHj\\Mafatih\\ErfanDatabase\\"
dirFinal=f"{dirDestination}\\allBabsfiles.json"
with open(dirFinal, "w", encoding='utf8') as write_file:
    json.dump(ListSearch, write_file, ensure_ascii=False, indent=4)