"""project4 URL Configuration

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
from django.contrib import admin
from django.urls import path
from . import views
from django.conf import settings
from django.conf.urls.static import static



urlpatterns = [
    path('',views.first),
    path('index',views.index),
    path('studreg',views.studreg),
    path('login',views.login),
    path('logout',views.logout),
    path('adviewpro',views.adviewpro),
    path('addfaculty',views.addfaculty),
    path('viewfacultyadmin',views.viewfacultyadmin),
    path('remove/<int:id>',views.remove, name='remove'),
    path('viewstud',views.viewstud),
    path('delete/<int:id>',views.delete, name='delete'),
    path('adviewcom',views.adviewcom),
    path('adminack',views.adminack),
    path('adminackpage/<int:id>',views.adminackpage, name='adminackpage'),
    path('adminackpage/adminacksave/<int:id>',views.adminacksave, name='adminacksave'),
    path('studentpro',views.studentpro),
    path('studentproedit',views.studentproedit),
    path('updat/<int:id>',views.updat, name='updat'),
    path('updat/updates/<int:id>',views.updates, name='updates'),
    path('complaintpages',views.complaintpages),
    path('complaintreg',views.complaintreg),
    path('viewackstd',views.viewackstd),
    path('viewfaculty',views.viewfaculty),
    path('facultyproedit',views.facultyproedit),
    path('facultyupdat/<int:id>',views.facultyupdat, name='facultyupdat'),
    path('facultyupdat/facultyupdates/<int:id>',views.facultyupdates, name='facultyupdates'),
    path('viewcomplaint',views.viewcomplaint),
    path('statused/<int:id>',views.statused, name='statused'),
    path('ackfaculty',views.ackfaculty),
    path('ackfacultys/<int:id>',views.ackfacultys, name='ackfacultys'),
    path('ackfacultys/ackfacultysave/<int:id>',views.ackfacultysave, name='ackfacultysave'),
    path('viewadminack',views.viewadminack),
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
