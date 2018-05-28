import datetime

from django.forms import widgets as fwidgets
from django.shortcuts import render
from django.http import HttpResponseRedirect, HttpResponse
from django.db import transaction, IntegrityError
from django import forms

from BroadviewCOSS import models, urls

import json


class LoginForm(forms.ModelForm):
    remember_me = forms.BooleanField(
        required=False,
        widget=fwidgets.CheckboxInput(attrs={'title': '如果要记住用户名，请选中'})
    )

    class Meta:
        model = models.User
        fields = ['username', 'password']
        widgets = {
            'username': fwidgets.TextInput(
                attrs={'class': 'form-control', 'placeholder': '用户名', 'title': '请输入用户名', 'autofocus': 'autofocus'}),
            'password': fwidgets.PasswordInput(
                attrs={'class': 'form-control', 'placeholder': '密码', 'title': '请输入密码'}),
        }
        error_messages = {
            'username': {
                'required': '用户名不能为空'
            },
            'password': {
                'required': '密码不能为空'
            }
        }


def login(request):
    if request.method == 'POST':
        lf = LoginForm(request.POST)
        if lf.is_valid():
            data = lf.cleaned_data

            username = data['username']
            password = data['password']

            models.User.objects.filter(username=username, password=password)

            return HttpResponseRedirect('/')
        else:
            return HttpResponseRedirect('/login')
    else:
        lf = LoginForm()
        return render(request, 'BroadviewCOSS/login.html', {'LoginForm': lf})


def index(request):
    menus = models.Menu.objects.all()
    return render(request, 'BroadviewCOSS/index.html', {'menus': menus, 'active': 'index'})


def mainframe(request):
    menus = models.Menu.objects.all()
    return render(request, 'BroadviewCOSS/mainframe.html', {'menus': menus})


def category(request):
    return render(request, 'BroadviewCOSS/category.html', {})


def task(request):
    return render(request, 'BroadviewCOSS/task.html', {})


def user(request):
    menus = models.Menu.objects.all()
    permissions = models.Permission.objects.all()

    user_list = models.User.objects.all()

    user_dict = {}
    for u in user_list:
        ud = user_dict[u.id] = {}
        ud['username'] = u.username
        ud['userrole'] = u.userrole.role.name
        ud['is_active'] = u.is_active

        if isinstance(u.last_login, datetime.datetime):
            ud['last_login'] = u.last_login.strftime('%Y-%m-%d %H:%M:%S')
        else:
            ud['last_login'] = ""

    return_value = {
        'menus': menus,
        'permissions': permissions,
        'users': user_dict,
        'active': 'user'
    }
    return render(request, 'BroadviewCOSS/user.html', return_value)

def show_user(request):
    if request.method == 'POST':
        user_count = models.User.objects.all().count()

        draw = int(request.POST.get('draw'))
        start = int(request.POST.get('start'))  # 从多少行开始
        length = int(request.POST.get('length'))  # 显示多少条数据

        end = start + length
        user_list = models.User.objects.all().values_list(
            'id',
            'username',
            'userrole',
            'last_login',
            'is_active'
        ).order_by('id')[start:end]

        _filter = user_count
        all_lists = map(list, user_list)

        all_list = []
        for u in all_lists:
            u[2] = models.UserRole.objects.get(id=u[2]).role.name
            if isinstance(u[3], datetime.datetime):
                u[3] = u[3].strftime('%Y-%m-%d %H:%M:%S')
            all_list.append(u)

        data = {
            'draw': draw,
            'recordsTotal': user_count,
            'recordsFilter': _filter,
            'data': all_list
        }

        return HttpResponse(json.dumps(data))

def user_name_validate(request):
    username = request.POST.get('username')
    is_validate = models.User.objects.filter(username=username).exists()

    return HttpResponse(json.dumps(is_validate))

def user_add(request):
    menus = models.Menu.objects.all()
    permissions = models.Permission.objects.all()
    roles = models.Role.objects.all()

    if request.method == 'POST':
        data = json.loads(request.body)
        username = data['username']
        role_id = data['user-role']
        password = data['password']

        try:
            with transaction.atomic():
                r = models.Role.objects.get(id=role_id)
                u = models.User.objects.create(
                    username=username,
                    password=password,
                    is_active=True
                )
                u.userrole = models.UserRole.objects.create(
                    user=u,
                    role=r
                )
                context = {'result': True, 'message': '用户添加成功'}
        except (ValueError, IntegrityError, Exception):
            context = {'result': False, 'message': '用户添加失败'}

        return HttpResponse(json.dumps(context))
    else:
        return_value = {
            'menus': menus,
            'permissions': permissions,
            'roles': roles,
            'active': 'user'
        }
        return render(request, 'BroadviewCOSS/user-add.html', return_value)

@transaction.atomic()
def role(request):
    role_list = models.Role.objects.all()

    role_dict = {}
    for r in role_list:
        rd = role_dict[r.id] = {}
        rd['name'] = r.name
        rd['description'] = r.description
        rd['permission'] = r.rolepermission.permission

        menu_str = ""
        menu_role_list = r.menurole_set.all()
        for menu_role in menu_role_list:
            menu_str += menu_role.menu.name + ","

        rd['menu'] = menu_str.strip(",")

    result = request.session.get('role-result', None)
    if result:
        del request.session['role-result']

    return_value = {
        'roles': role_dict,
        'menus': models.Menu.objects.all(),
        'active': 'role',
        'result': result
    }
    return render(request, 'BroadviewCOSS/role.html', return_value)


def role_name_validate(request):
    role_name = request.POST.get('role_name')
    is_validate = models.Role.objects.filter(name=role_name).exists()

    return HttpResponse(json.dumps(is_validate))


@transaction.atomic()
def role_add(request):
    menus = models.Menu.objects.all()
    permissions = models.Permission.objects.all()

    if request.method == 'POST':
        role_name = request.POST.get('role-name')
        role_permission_id = request.POST.get('role-permission')
        role_menu_ids = request.POST.getlist('role-menu')
        role_desc = request.POST.get('role-desc')

        try:
            with transaction.atomic():
                r = models.Role(name=role_name, description=role_desc)
                r.save()

                p = models.Permission.objects.get(pk=role_permission_id)
                role_permission = models.RolePermission(role=r, permission=p)
                role_permission.save()

                for menu_id in role_menu_ids:
                    menu = models.Menu.objects.get(pk=menu_id)
                    menu_role = models.MenuRole(menu=menu, role=r)
                    menu_role.save()

                result = True
        except (ValueError, IntegrityError):
            result = False

        if result:
            request.session['role-result'] = {'value': True, 'message': '角色添加成功'}
            return HttpResponseRedirect('/role')
        else:
            return_value = {
                'menus': menus,
                'permissions': permissions,
                'active': 'role',
                'result': {
                    'value': False,
                    'message': '角色添加失败'
                }
            }
            return render(request, 'BroadviewCOSS/role-add.html', return_value)
    else:
        return_value = {
            'menus': menus,
            'permissions': permissions,
            'active': 'role'
        }
        return render(request, 'BroadviewCOSS/role-add.html', return_value)


@transaction.atomic()
def role_update(request):
    menus = models.Menu.objects.all()
    permissions = models.Permission.objects.all()

    if request.method == 'POST':
        data = json.loads(request.body)
        role_id = data['role-id']
        role_name = data['role-name']
        role_permission_id = data['role-permission']
        role_menu_ids = data['role-menu']
        role_desc = data['role-desc']

        try:
            with transaction.atomic():
                r = models.Role.objects.get(id=role_id)
                p = models.Permission.objects.get(id=role_permission_id)

                r.name = role_name
                r.description = role_desc
                r.save()

                r.rolepermission.permission = p
                r.rolepermission.save()

                r.menurole_set.all().delete()
                for menu_id in role_menu_ids:
                    menu = models.Menu.objects.get(pk=menu_id)
                    r.menurole_set.create(menu=menu)

                context = {'result': True, 'message': '角色修改成功'}
        except (ValueError, IntegrityError, AttributeError) as e:
            context = {'result': False, 'message': '角色修改失败'}

        return HttpResponse(json.dumps(context))
    else:
        role_id = request.GET.get('role-id')
        r = models.Role.objects.get(id=role_id)

        p_id = r.rolepermission.permission.id

        menu_role_list = r.menurole_set.all()
        menu_list = []
        for menu_role in menu_role_list:
            menu_list.append(menu_role.menu.id)

        role_dict = {
            'id': r.id,
            'name': r.name,
            'description': r.description,
            'permission': p_id,
            'menu': menu_list
        }

        return_value = {
            'role': role_dict,
            'menus': menus,
            'permissions': permissions,
            'active': 'role'
        }
        return render(request, 'BroadviewCOSS/role-update.html', return_value)


@transaction.atomic()
def role_delete(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        role_id = data['role-id']

        try:
            with transaction.atomic():
                models.Role.objects.get(id=role_id).delete()
                context = {'result': True, 'message': '角色删除成功'}
        except (ValueError, IntegrityError, AttributeError) as e:
            context = {'result': False, 'message': '角色修改失败'}

        return HttpResponse(json.dumps(context))
    else:
        return HttpResponseRedirect("/role")
