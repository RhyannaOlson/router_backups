'''python script'''
import datetime
import pathlib
import os
import netmiko
from getpass import getpass
from pathlib import Path
from datetime import datetime
from netmiko import ConnectHandler
user = input('please type your username: ')

secret = getpass("please type your password: ")

working = Path.cwd()
date = datetime.now().strftime("%Y_%m_%d-%I:%M:%S_%p")
fileName = f"csrBackup_{date}.txt"
write = 'w'
backupFile = open(fileName, write)
routerIP = str('192.168.108.220')
dict = {'ip': routerIP, 'username': user, 'password': secret, 'device_type': 'cisco_ios'}
connection = ConnectHandler(**dict)
output = connection.send_command('show run')
backupFile.write(output)
backupFile.close()
