from django.db import models


# Create your models here.

class UserInfo(models.Model):
    name = models.CharField(max_length=32)
    password = models.CharField(max_length=64)
    age = models.IntegerField()
    email = models.EmailField(max_length=64)


class AreaInfo(models.Model):
    name = models.CharField(max_length=32)
    length = models.FloatField()
    width = models.FloatField()
    state = models.CharField(max_length=32)
    ap1 = models.CharField(max_length=32)
    ap2 = models.CharField(max_length=32)
    ap3 = models.CharField(max_length=32)
    ap4 = models.CharField(max_length=32)


class DeviceInfo(models.Model):
    mac = models.CharField(max_length=32)
    abbreviation = models.CharField(max_length=32)
    device_mold = models.CharField(max_length=32)
    user_mold = models.CharField(max_length=32)


class LocInfo(models.Model):
    mac = models.CharField(max_length=64)
    x = models.FloatField()
    y = models.FloatField()
    create_time = models.DateTimeField(auto_now_add=True)
    edit_time = models.DateTimeField(auto_now=True)
