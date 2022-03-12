import datetime
import pathlib
from pathlib import Path
from datetime import datetime
import os
import netmiko
import paramiko
from netmiko import ConnectHandler
from getpass import getpass
from netmiko.ssh_exception import AuthenticationException
from paramiko.ssh_exception import SSHException
from netmiko.ssh_exception import NetMikoTimeoutException

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
except (NetMikoTimeoutException):
    print("The device " + routerIP + " timed out while trying to connect.")
except (AuthenticationException):
    print("An authentication error occured while trying to connect to " + routerIP)
except (SSHException):
    print("An error occured while connecting to " + routerIP + " via SSH. Is SSH enabled?")
except (EOFError):
    print("End os file error occured while attempting to connect to " + routerIP)
except Exception as other_error:
    print(" the error " + str(other_error) + " occured while connecting to " + routerIP)


print(output)
print("The script ran successfully")
