import json
import os
import shutil


import pandas as pd
excel_file='/Users/msh/Developer/Flutter/Mafatih/Audios Collector/db.xlsx'
df = pd.read_excel(excel_file, sheet_name = "db" , index_col=None, na_values=['NA'])

mapIds={}
for i, id in enumerate(df["applicationId"]):
    try:
        mapIds[df["applicationId"][i]]=int(df["Code"][i])
    except:
        pass
    
listCodesinStr=[]
for i in list(mapIds.values()):
    listCodesinStr.append(str(i))
    
import json
print(json.dumps(listCodesinStr))

filelocation=f"/Users/msh/Developer/Flutter/Kernel_app_kochulo"

listFiles = os.listdir(filelocation) # dir is your directory path
number_files = len(listFiles)
listFiles.sort()
listFiles
desFolder="/Users/msh/Developer/Flutter/Mafatih/Audios Collector"
for f in listFiles:


    try:
            soundLocation=f"{filelocation}/{f}/KernelFiles/assets/sounds"
            listSoundFiles = os.listdir(soundLocation)
            listSoundFiles.sort()
            shutil.copy(soundLocation+f"/{listSoundFiles[0]}", desFolder+f"/{int(mapIds[f])}.mp3")
            print(desFolder+f"/{int(mapIds[f])}.mp3")
        
    except:
        pass
    