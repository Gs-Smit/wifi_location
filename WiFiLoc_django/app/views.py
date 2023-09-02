from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.contrib.auth.models import User
from django.http import JsonResponse
import time
import random
import json

from django.contrib.auth import authenticate, login, logout
from app.models import AreaInfo, DeviceInfo
from app.wifilocation import csi_loc


# Create your views here.

@login_required
def runconfiguration(request):
    dev_infos = DeviceInfo.objects.all()
    # 将列表内的字符串逐行写入文本文件
    with open('./app/wifilocation/devs_mac.txt', "w") as file:
        for dev in dev_infos.values():
            file.write(dev['mac'] + "\n")
    if request.method == 'GET':
        max_id_area = AreaInfo.objects.order_by('-id').first()
        if max_id_area:
            return render(request, "configuration.html", {'area': max_id_area, 'dev_infos': dev_infos})
        else:
            area = AreaInfo.objects
            area.name = ""
            return render(request, "configuration.html", {'area': area, 'dev_infos': dev_infos})
    name = request.POST.get("name")
    length = request.POST.get("length")
    width = request.POST.get("width")
    state = request.POST.get("state")
    ap1 = request.POST.get("ap1")
    ap2 = request.POST.get("ap2")
    ap3 = request.POST.get("ap3")
    ap4 = request.POST.get("ap4")

    info = request.POST.dict()
    info.pop('name')
    # 尝试从数据库中获取该地区对象
    area, created = AreaInfo.objects.get_or_create(name=name, length=length, width=width, state=state, ap1=ap1, ap2=ap2,
                                                   ap3=ap3, ap4=ap4)
    if not created:
        # 如果已存在该地区，则修改其他属性
        area.length = length
        area.width = width
        area.state = state
        area.ap1 = ap1
        area.ap2 = ap2
        area.ap3 = ap3
        area.ap4 = ap4
        area.save()
    return render(request, "configuration.html", {'area': area, 'msg': '修改成功', 'dev_infos': dev_infos})


@login_required
def addDevice(request):
    # 检查DeviceInfo表的记录数是否小于4
    if DeviceInfo.objects.count() < 4:
        mac = request.POST.get("mac")
        abbreviation = request.POST.get("abbreviation")
        device_mold = request.POST.get("device_mold")
        user_mold = request.POST.get("user_mold")
        # 创建并保存新的DeviceInfo对象
        new_device = DeviceInfo(mac=mac, abbreviation=abbreviation, device_mold=device_mold, user_mold=user_mold)
        new_device.save()
    return redirect('/configuration/')  # 重定向到显示设备列表的页面


@login_required
def runloc(request):
    return render(request, 'location.html', {'x': 0.5, 'y': 0.5})


def wifiloc(request):
    # 模拟获取定位结果
    data = csi_loc.run_loc()
    return JsonResponse(data)


def user_login(request):
    if request.user.is_authenticated:
        return redirect('/configuration/')
    if request.method == 'GET':
        return render(request, "login.html")
    username = request.POST.get("username")
    password = request.POST.get("pwd")
    user = authenticate(request, username=username, password=password)
    if user is not None:
        login(request, user)
        return redirect('/configuration/')
    # 处理登录失败的情况
    return render(request, "login.html", {'error_msg': '用户名或密码错误'})


def user_logout(request):
    logout(request)
    return redirect('/')


def signup(request):
    if request.method == 'GET':
        return render(request, "signup.html")
    username = request.POST.get("username")
    first_name = request.POST.get("first_name")
    last_name = request.POST.get("last_name")
    email = request.POST.get("email")
    password = request.POST.get("password")
    confirm_password = request.POST.get("confirm_password")

    # 检查用户名是否已存在
    if User.objects.filter(username=username).exists():
        return render(request, 'signup.html', {'msg': 'Username already exists'})

    if not password == confirm_password:
        return render(request, 'signup.html', {'msg': 'Passwords does not match'})

    # 创建新用户
    user = User.objects.create_user(username=username, password=password, first_name=first_name, last_name=last_name,
                                    email=email)

    return render(request, "signup.html", {'msg': 'User added successfully'})
