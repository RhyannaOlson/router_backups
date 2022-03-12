import datetime
import pathlib
from pathlib import Path
from datetime import datetime
import os
import netmiko
import paramiko
from netmiko import ConnectHandler
from getpass import getpass
from netmiko.ssh_exception import AuthenticationException, SSHException, NetMikoTimeoutException

user = input('please type your username: ')

secret = getpass("please type your password: ")

working = Path.cwd()
date = datetime.now().strftime("%Y_%m_%d-%I:%M:%S_%p")
fileName = f"csrBackup_{date}.txt"
write = 'w'
backupFile = open(fileName, write)
routerIP = str('192.168.108.220')
dict = {'ip': routerIP, 'username': user, 'password': secret, 'device_type': 'cisco_ios'}
try:
  connection = ConnectHandler(**dict)
  output = connection.send_command('show run')
  backupFile.write(output)
  backupFile.close()
except (AuthenticationException):
  print("An authentication error occured while trying to connect to " + routerIP)
except (SSHException):
  print("The device " + routerIP + " timed out while trying to connect.")
except (NetMikoTimeoutException):
  print("An error occured while connecting to " + routerIP + " via SSH. Is SSH enabled?")

print("The script ran successfully")
