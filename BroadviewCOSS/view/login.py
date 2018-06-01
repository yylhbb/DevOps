import datetime
import json

from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render

from BroadviewCOSS import models


def login(request):
    """
    登陆
    :param request:
    :return:
    """
    if request.method == 'POST':
        data = json.loads(request.body)
        username = data['username']
        password = data['password']

        u = models.User.objects.filter(username=username)
        if not u.exists():
            context = {
                'result': False,
                'message': '用户名不存在'
            }
        else:
            u = u.filter(password=password)
            if u.exists():
                if u.filter(is_active=True):
                    request.session['username'] = username
                    request.session.set_expiry(7200)

                    u.update(last_login=datetime.datetime.now())

                    context = {
                        'result': True,
                        'message': '登陆成功'
                    }
                else:
                    context = {
                        'result': False,
                        'message': '该用户已被锁定'
                    }
            else:
                context = {
                    'result': False,
                    'message': '密码错误'
                }

        return HttpResponse(json.dumps(context))
    else:
        username = request.session.get('username', None)
        if username:
            return HttpResponseRedirect('/index')
        else:
            return render(request, 'BroadviewCOSS/login.html')


def logout(request):
    """
    登出
    :param request:
    :return:
    """
    del request.session['username']

    return HttpResponseRedirect('/login')
