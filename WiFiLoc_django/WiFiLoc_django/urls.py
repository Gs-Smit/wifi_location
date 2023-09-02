"""WiFiLoc_django URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.urls import path
from app import views

urlpatterns = [
    path('configuration/', views.runconfiguration),
    path('location/', views.runloc),
    path('', views.user_login),
    path('logout/', views.user_logout),
    path('signup/', views.signup),
    path('adddevice/', views.addDevice),
    path('startwifiloc/', views.wifiloc),

]
