from django.http import HttpResponseRedirect
from django.shortcuts import render

from . import utils

def index(request):
    username = request.session.get('username', None)

    if utils.check_access(request=request, url='index'):

        context = {
            'menus': utils.get_menus(username),
            'active': 'index'
        }
        return render(request, 'BroadviewCOSS/index.html', context)
    else:
        return HttpResponseRedirect('/login')