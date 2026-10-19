from django.http import HttpResponse
from django.shortcuts import render
from django.shortcuts import redirect
from  django.core.files.storage import FileSystemStorage
from django.conf import settings
from .models import *


def index(request):
    return render(request,'index.html')

def first(request):
    return render(request,'index.html')

def studreg(request):
    if request.method=="POST":
        image=request.FILES['image']
        f=FileSystemStorage()
        fs=f.save(image.name,image)
        name=request.POST.get('name')
        phone=request.POST.get('phone')
        email=request.POST.get('email')
        password=request.POST.get('password')
        registration=complaintboxregister(name=name,phone=phone,email=email,image=image,password=password)
        registration.save()
    return render(request,'studreg.html',{'succes':'registered suucessfully'})


def login(request):
    email = request.POST.get('email')
    password = request.POST.get('password')
    if email == 'admin@gmail.com' and password =='admin':
        request.session['logintdetail'] = email
        request.session['admin'] = 'admin'
        return render(request, 'index.html')

    elif complaintboxregister.objects.filter(email=email,password=password).exists():
        userdetail=complaintboxregister.objects.get(email=request.POST['email'], password=password)
        if userdetail.password == request.POST['password']:
            request.session['uid'] = userdetail.id
            request.session['uname'] = userdetail.name

            request.session['email'] = email

            request.session['user'] = 'user'

            return render(request,'index.html')
        

    elif complaintboxfaculty.objects.filter(email=email,password=password).exists():
        userdetail=complaintboxfaculty.objects.get(email=request.POST['email'], password=password)
        if userdetail.password == request.POST['password']:
            request.session['fuid'] = userdetail.id
            request.session['uname'] = userdetail.name

            request.session['email'] = email

            request.session['fuser'] = 'fuser'

            return render(request,'index.html')
        
    else:
        return render(request, 'loginform.html', {'status': 'Invalid Username or Password'})
    

def logout(request):
    session_keys = list(request.session.keys())
    for key in session_keys:
      del request.session[key]
    return redirect(index)

# admin start 

def addfaculty(request):
    if request.method=="POST":
        designation=request.POST.get('designation')
        name=request.POST.get('name')
        email=request.POST.get('email')
        password=request.POST.get('password')
        registration=complaintboxfaculty(name=name,designation=designation,email=email,password=password)
        registration.save()
    return render(request,'addfaculty.html',{'succes':'registered suucessfully'})


def adviewpro(request):
    return render(request,'adviewpro.html')


def viewfacultyadmin(request):
    users=complaintboxfaculty.objects.all()
    return render(request,'viewfacultyadmin.html',{'res':users})

def remove(request,id):
    member = complaintboxfaculty.objects.get(id=id)
    member.delete()
    return redirect(viewfacultyadmin)

def viewstud(request):
    users=complaintboxregister.objects.all()
    return render(request,'viewstudent.html',{'res':users})

def delete(request,id):
    member = complaintboxregister.objects.get(id=id)
    member.delete()
    return redirect(viewstud)

def adviewcom(request):
    users=complaintboxcomplaint.objects.all()
    return render(request,'adviewcomplaint.html',{'res':users})

def adminack(request):
    return render(request,'adminack.html')

def adminackpage(request,id):
    users=complaintboxcomplaint.objects.get(id=id)
    return render(request,'adminack.html',{'res':users})

def adminacksave(request,id):
    if request.method=="POST":
        ackto=request.POST.get('ackto')
        date=request.POST.get('date')
        name=request.POST.get('name')
        email=request.POST.get('email')
        ackmesg=request.POST.get('ackmesg')
        reg=complaintboxackadmfac(ackto=ackto,date=date,name=name,email=email,ackmesg=ackmesg,id=id)
        reg.save()
        return redirect(adviewcom)


# admin end 


# student start 

def studentpro(request):
    tem=request.session['uid']
    vpro=complaintboxregister.objects.get(id=tem)
    return render(request,'studentprofile.html',{'result':vpro})

def studentproedit(request):
    return render(request,'studentproedit.html')

def updat(request,id):
    upt=complaintboxregister.objects.get(id=id)
    return render(request,'studentproedit.html',{'result':upt})

def updates(request,id):
    if request.method=="POST":
        image=request.FILES['image']
        f=FileSystemStorage()
        fs=f.save(image.name,image)
        name=request.POST.get('name')
        phone=request.POST.get('phone')
        email=request.POST.get('email')
        password=request.POST.get('password')
        registration=complaintboxregister(name=name,phone=phone,email=email,image=image,password=password,id=id)
        registration.save()
        return redirect(studentpro)
     

def complaintpages(request):
    tem=request.session['uid']
    upt=complaintboxregister.objects.get(id=tem)
    vpro=complaintboxfaculty.objects.all()
    return render(request,'studcomreg.html',{'result':upt,'res':vpro})

def complaintreg(request):
    tem=request.session['uid']
    if request.method=="POST":
        complaintto=request.POST.get('complaintto')
        date=request.POST.get('date')
        name=request.POST.get('name')
        email=request.POST.get('email')
        complaintmesg=request.POST.get('complaintmesg')
        reg=complaintboxcomplaint(complaintto=complaintto,date=date,name=name,email=email,complaintmesg=complaintmesg,userid=tem,status='not viewed')
        reg.save()
    return render(request,'studcomreg.html',{'succes':'registered suucessfully'})


def viewackstd(request):
    tem=request.session['uid']
    vpro=complaintboxacknowledgement.objects.filter(replyto=tem)
    return render(request,'viewackstd.html',{'res':vpro})


# student end 


def viewfaculty(request):
    tem=request.session['fuid']
    vpro=complaintboxfaculty.objects.get(id=tem)
    return render(request,'viewfacultyprofil.html',{'result':vpro})


def facultyproedit(request):
    return render(request,'facultyproedit.html')


def facultyupdat(request,id):
    upt=complaintboxfaculty.objects.get(id=id)
    return render(request,'facultyproedit.html',{'result':upt})

def facultyupdates(request,id):
    if request.method=="POST":
        designation=request.POST.get('designation')
        name=request.POST.get('name')
        email=request.POST.get('email')
        password=request.POST.get('password')
        registration=complaintboxfaculty(name=name,designation=designation,email=email,password=password,id=id)
        registration.save()
        return redirect(viewfaculty)
    
def viewcomplaint(request):
    tem=request.session['fuid']
    users=complaintboxcomplaint.objects.filter(complaintto=tem)
    return render(request,'complaintview.html',{'res':users})



def statused(request,id):
    upt=complaintboxcomplaint.objects.filter(id=id)
    upt.update(status='viewed')
    return redirect(viewcomplaint)



def ackfaculty(request):
    return render(request,'ackfaculty.html')

def ackfacultys(request,id):
    tem=request.session['fuid']
    upt=complaintboxfaculty.objects.get(id=tem)
    users=complaintboxcomplaint.objects.get(id=id)
    return render(request,'ackfaculty.html',{'res':users,'result':upt})

def ackfacultysave(request,id):
    if request.method=="POST":
        replyto=request.POST.get('replyto')
        date=request.POST.get('date')
        name=request.POST.get('name')
        email=request.POST.get('email')
        ackmesg=request.POST.get('ackmesg')
        registration=complaintboxacknowledgement(replyto=replyto,date=date,name=name,email=email,ackmesg=ackmesg,id=id)
        registration.save()
        return redirect(viewcomplaint)
    

def viewadminack(request):
    tem=request.session['fuid']
    users=complaintboxackadmfac.objects.filter(ackto=tem)
    return render(request,'facadminack.html',{'res':users})