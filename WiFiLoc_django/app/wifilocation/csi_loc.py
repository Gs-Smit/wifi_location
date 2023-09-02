import subprocess
import random


def get_devs_mac():
    file_path = './app/wifilocation/devs_mac.txt'
    devs_mac = []
    with open(file_path, 'r') as file:
        for line in file:
            mac = line.strip()  # 去掉行末的换行符和空格
            devs_mac.append(mac)
    return devs_mac


def get_aps_ip():
    file_path = './app/wifilocation/aps_ip.txt'
    aps_ip = []
    with open(file_path, 'r') as file:
        for line in file:
            ip = line.strip()  # 去掉行末的换行符和空格
            aps_ip.append(ip)
    return aps_ip


def mac_coding(devs_mac):
    coded_mac = []
    for mac_address in devs_mac:
        try:
            completed_process = subprocess.run(['sh', './app/wifilocation/shell/mac_code.sh', mac_address],
                                               stdout=subprocess.PIPE,
                                               stderr=subprocess.PIPE, check=True)
            command_output = completed_process.stdout.decode('utf-8').strip()
            coded_mac.append(command_output)
            print("Command output:", command_output)
        except subprocess.CalledProcessError as e:
            print("Error:", e)
    return coded_mac


def csi_collect(coded_mac):
    pass


def aoa_loc(csi):
    pass


def run_loc():
    data = {'x': 0.25 + random.uniform(-0.05, 0.05), 'y': 0.4 + random.uniform(-0.05, 0.05)}
    return data
