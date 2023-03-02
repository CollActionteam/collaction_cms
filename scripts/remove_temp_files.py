import os
import shutil
import argparse
import tqdm

# In windows, flutter web is generating temp files that are quite heavy, aprox 500MB - 1GB
# https://github.com/flutter/flutter/issues/84094

# If you are experiencing this, you can run this script to clean those files.
# Check in the following path C:\\Users\\<username>\\AppData\\Local\\Temp if you have any folders with the name
# flutter_tools...

# run this with the following command: py ./RELATIVE_PATH_TO_FILE/remove_temp_files.py --username <your-username>
# E.g: py ./scripts/remove_temp_files.py --username dash (from root folder)

parser = argparse.ArgumentParser(description= 'Script to delete Temp files created by flutter')
parser.add_argument('-un', '--username')
args = parser.parse_args()
username = args.username

if username == None:
    raise Exception("User need to be provided with -un flag \n C:\\Users\\<username>\\AppData\\Local\\Temp")

temp_folders_path = f"C:\\Users\\{username}\\AppData\\Local\\Temp"

directory = os.listdir(temp_folders_path)
for file in tqdm.tqdm(directory):
    if(file.startswith("flutter_tools")):
        path = temp_folders_path + "\\" + file
        shutil.rmtree(path)
