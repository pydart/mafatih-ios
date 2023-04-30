import json
import os
from natsort import natsorted # pip install natsort

ListSearch=[]

for i in range(1,4):
    babcount=i
    filelocation=f"G:\\Flutter\\Qurani2_Babs_SplitText\\python\\Babs\\{babcount}"

    listFiles = natsorted(os.listdir(filelocation))  # dir is your directory path
    number_files = len(listFiles)
    for onefile in listFiles:

        dirr= f"{filelocation}\\{onefile}"
        # print(dirr)
        f = open(dirr, "r", encoding='utf8')
        fileRead = json.load(f)
        print(onefile[:-5])
        fileFinal=fileRead[onefile[:-5]]


        fileFinal["indexbab"] =int(onefile[:-5])
        ListSearch.append(fileFinal)


dirDestination="G:\\Flutter\\Qurani2_Babs_SplitText\\python\\Babs"
dirFinal=f"{dirDestination}\\ListofJsonForSearch.json"
with open(dirFinal, "w", encoding='utf8') as write_file:
    json.dump(ListSearch, write_file, ensure_ascii=False, indent=4)