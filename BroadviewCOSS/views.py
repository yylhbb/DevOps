import datetime

from django.core.exceptions import PermissionDenied
from django.shortcuts import render
from django.http import HttpResponseRedirect, HttpResponse
from django.db import transaction, IntegrityError
from BroadviewCOSS import models

import json


def login(request):
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
    del request.session['username']
    return HttpResponseRedirect('/login')


def index(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'index'):
            u = models.User.objects.get(username=username)

            if isinstance(u.last_login, datetime.datetime):
                last_login = u.last_login.strftime('%Y-%m-%d %H:%M:%S')
            else:
                last_login = ""

            return_value = {
                'username': u.username,
                'last_login': last_login,
                'menus': menus,
                'active': 'index'
            }
            return render(request, 'BroadviewCOSS/index.html', return_value)
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


def mainframe(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'mainframe'):
            m_list = models.Mainframe.objects.all()

            return_value = {
                'menus': menus,
                'mainframes': m_list,
                'active': 'mainframe'
            }
            return render(request, 'BroadviewCOSS/mainframe.html', return_value)
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


def mainframe_ip_validate(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'mainframe'):
            m_id = request.POST.get('m-id')
            m_ip = request.POST.get('m-ip')

            if m_id is None or not models.Mainframe.objects.get(id=m_id).ip == m_ip:
                is_validate = models.Mainframe.objects.filter(ip=m_ip).exists()
            else:
                is_validate = False

            return HttpResponse(json.dumps(not is_validate))
    else:
        return HttpResponseRedirect('/login')


@transaction.atomic()
def mainframe_add(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'mainframe'):
            if request.method == 'POST':
                if verify_permission(username, 'update'):
                    data = json.loads(request.body)
                    m_ip = data['m-ip']
                    m_host = data['m-host']
                    if not m_host:
                        m_host = 9876
                    m_hostname = data['m-hostname']
                    m_category_id = data['m-category']
                    m_desc = data['m-desc']

                    try:
                        with transaction.atomic():
                            models.Mainframe.objects.create(
                                ip=m_ip,
                                host=m_host,
                                hostname=m_hostname,
                                status=2,
                                category=models.Category.objects.get(id=m_category_id),
                                description=m_desc
                            )

                            context = {
                                'result': True,
                                'message': '主机添加成功'
                            }
                    except (ValueError, IntegrityError, AttributeError, Exception):
                        context = {
                            'result': False,
                            'message': '主机添加失败'
                        }
                else:
                    context = {
                        'result': False,
                        'message': '权限不足'
                    }

                return HttpResponse(json.dumps(context))
            else:
                return_value = {
                    'menus': menus,
                    'categories': models.Category.objects.all(),
                    'active': 'mainframe'
                }
                return render(request, 'BroadviewCOSS/mainframe-add.html', return_value)
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


@transaction.atomic()
def mainframe_update(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'mainframe'):
            if request.method == 'POST':
                if verify_permission(username, 'update'):
                    data = json.loads(request.body)
                    m_id = data['m-id']
                    m_ip = data['m-ip']
                    m_host = data['m-host']
                    if not m_host:
                        m_host = 9876

                    m_hostname = data['m-hostname']
                    m_category_id = data['m-category']
                    m_desc = data['m-desc']

                    try:
                        with transaction.atomic():
                            m = models.Mainframe.objects.get(id=m_id)
                            m.ip = m_ip
                            m.host = m_host
                            m.hostname = m_hostname
                            m.description = m_desc
                            m.category = models.Category.objects.get(id=m_category_id)

                            m.save()

                            context = {
                                'result': True,
                                'message': '主机修改成功'
                            }
                    except (ValueError, IntegrityError, AttributeError, Exception):
                        context = {
                            'result': False,
                            'message': '主机修改失败'
                        }
                else:
                    context = {
                        'result': False,
                        'message': "权限不足"
                    }

                return HttpResponse(json.dumps(context))
            else:
                m_id = request.GET.get('m-id')
                m = models.Mainframe.objects.get(id=m_id)

                return_value = {
                    'mainframe': m,
                    'categories': models.Category.objects.all(),
                    'menus': menus,
                    'active': 'mainframe'
                }
                return render(request, 'BroadviewCOSS/mainframe-update.html', return_value)
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


def mainframe_delete(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'category'):
            if request.method == 'POST':
                if verify_permission(username, 'delete'):
                    data = json.loads(request.body)
                    m_id = data['id']

                    try:
                        with transaction.atomic():
                            models.Mainframe.objects.get(id=m_id).delete()

                            context = {
                                'result': True,
                                'message': '主机删除成功'
                            }
                    except (ValueError, IntegrityError, AttributeError, Exception):
                        context = {
                            'result': False,
                            'message': '主机删除失败'
                        }
                else:
                    context = {
                        'result': False,
                        'message': '权限不足'
                    }

                return HttpResponse(json.dumps(context))
            else:
                return HttpResponseRedirect('/mainframe')
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


def category(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'category'):
            c_list = models.Category.objects.exclude(id=0)

            return_value = {
                'menus': menus,
                'categories': c_list,
                'active': 'category'
            }
            return render(request, 'BroadviewCOSS/category.html', return_value)
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


def category_name_validate(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'category'):
            c_id = request.POST.get('c-id')
            c_name = request.POST.get('c-name')

            if c_id is None or not models.Category.objects.get(id=c_id).name == c_name:
                is_validate = models.Category.objects.filter(name=c_name).exists()
            else:
                is_validate = False

            return HttpResponse(json.dumps(not is_validate))
    else:
        return HttpResponseRedirect('/login')


@transaction.atomic()
def category_add(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'category'):
            if request.method == 'POST':
                if verify_permission(username, 'update'):
                    data = json.loads(request.body)
                    c_name = data['c-name']
                    c_desc = data['c-desc']

                    try:
                        with transaction.atomic():
                            models.Category.objects.create(
                                name=c_name,
                                description=c_desc
                            )
                            context = {
                                'result': True,
                                'message': '分类添加成功'
                            }
                    except (ValueError, IntegrityError, AttributeError, Exception):
                        context = {
                            'result': False,
                            'message': '分类添加失败'
                        }
                else:
                    context = {
                        'result': False,
                        'message': '权限不足'
                    }

                return HttpResponse(json.dumps(context))
            else:
                return_value = {
                    'menus': menus,
                    'active': 'category'
                }
                return render(request, 'BroadviewCOSS/category-add.html', return_value)
        else:
            return PermissionDenied
    else:
        return HttpResponseRedirect('/login')


@transaction.atomic()
def category_update(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'category'):
            if request.method == 'POST':
                if verify_permission(username, 'update'):
                    data = json.loads(request.body)
                    c_id = data['c-id']
                    c_name = data['c-name']
                    c_desc = data['c-desc']

                    try:
                        with transaction.atomic():
                            c = models.Category.objects.get(id=c_id)
                            c.name = c_name
                            c.desc = c_desc
                            c.save()

                            context = {
                                'result': True,
                                'message': '分类修改成功'
                            }
                    except (ValueError, IntegrityError, AttributeError, Exception):
                        context = {
                            'result': False,
                            'message': '分类修改失败'
                        }
                else:
                    context = {
                        'result': False,
                        'message': '权限不足'
                    }

                return HttpResponse(json.dumps(context))
            else:
                c_id = request.GET.get('c-id')
                c = models.Category.objects.get(id=c_id)

                return_value = {
                    'category': c,
                    'menus': menus,
                    'active': 'category'
                }

                return render(request, 'BroadviewCOSS/category-update.html', return_value)
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


@transaction.atomic()
def category_delete(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'category'):
            if request.method == 'POST':
                if verify_permission(username, 'delete'):
                    data = json.loads(request.body)
                    c_id = data['id']

                    try:
                        with transaction.atomic():
                            models.Category.objects.get(id=c_id).delete()

                            context = {
                                'result': True,
                                'message': '分类删除成功'
                            }
                    except (ValueError, IntegrityError, AttributeError, Exception):
                        context = {
                            'result': False,
                            'message': '分类删除失败'
                        }
                else:
                    context = {
                        'result': False,
                        'message': '权限不足'
                    }

                return HttpResponse(json.dumps(context))
            else:
                return HttpResponseRedirect('/category')
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


def task(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'task'):
            t_list = models.Task.objects.all()

            return_value = {
                'tasks': t_list,
                'menus': menus,
                'active': 'task'
            }
            return render(request, 'BroadviewCOSS/task.html', return_value)
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


def task_name_validate(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'task'):
            t = request.POST.get('t-name')
            is_validate = models.Task.objects.filter(name=t).exists()

            return HttpResponse(json.dumps(not is_validate))
    else:
        return HttpResponseRedirect('/login')


def task_add(request):
    pass


def task_update(request):
    pass


def task_delete(request):
    pass


def user(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'user'):
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
                'users': user_dict,
                'active': 'user'
            }
            return render(request, 'BroadviewCOSS/user.html', return_value)
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


def user_name_validate(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'user'):
            u_id = request.POST.get('user-id')
            u_name = request.POST.get('username')

            if u_id is None or not models.User.objects.get(id=u_id).username == u_name:
                is_validate = models.User.objects.filter(username=u_name).exists()
            else:
                is_validate = False

            return HttpResponse(json.dumps(not is_validate))
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


@transaction.atomic()
def user_add(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'user'):
            roles = models.Role.objects.all()

            if request.method == 'POST':
                if verify_permission(username, 'update'):
                    data = json.loads(request.body)
                    username = data['username']
                    role_id = data['user-role']
                    password = data['password']

                    try:
                        with transaction.atomic():
                            u = models.User.objects.create(
                                username=username,
                                password=password,
                                is_active=True
                            )
                            u.userrole = models.UserRole.objects.create(
                                user=u,
                                role=models.Role.objects.get(id=role_id)
                            )
                            context = {'result': True, 'message': '用户添加成功'}
                    except (ValueError, IntegrityError, Exception) as e:
                        context = {'result': False, 'message': '用户添加失败'}
                else:
                    context = {
                        'result': False,
                        'message': '权限不足'
                    }

                return HttpResponse(json.dumps(context))
            else:
                return_value = {
                    'menus': menus,
                    'roles': roles,
                    'active': 'user'
                }
                return render(request, 'BroadviewCOSS/user-add.html', return_value)
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


@transaction.atomic()
def user_update(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'user'):
            if request.method == 'POST':
                if verify_permission(username, 'update'):
                    data = json.loads(request.body)
                    user_id = data['user-id']
                    password = data['password']
                    role_id = data['user-role']
                    is_active = data['is-active']

                    try:
                        with transaction.atomic():
                            u = models.User.objects.get(id=user_id)
                            u.password = password
                            u.is_active = is_active
                            u.save()

                            u.userrole.role = models.Role.objects.get(id=role_id)
                            u.userrole.save()

                            context = {
                                'result': True,
                                'message': '用户修改成功'
                            }
                    except (ValueError, IntegrityError, AttributeError, Exception) as e:
                        context = {
                            'result': False,
                            'message': '用户修改失败'
                        }
                else:
                    context = {
                        'result': False,
                        'message': '权限不足'
                    }

                return HttpResponse(json.dumps(context))
            else:
                user_id = request.GET.get('user-id')
                u = models.User.objects.get(id=user_id)

                user_dict = {
                    'id': user_id,
                    'username': u.username,
                    'password': u.password,
                    'is_active': u.is_active,
                    'role': u.userrole.role.id
                }
                return_value = {
                    'user': user_dict,
                    'roles': models.Role.objects.all(),
                    'menus': menus,
                    'active': 'user'
                }

                return render(request, 'BroadviewCOSS/user-update.html', return_value)
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


@transaction.atomic()
def user_delete(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'user'):
            if request.method == 'POST':
                if verify_permission(username, 'delete'):
                    data = json.loads(request.body)
                    user_id = data['id']

                    try:
                        with transaction.atomic():
                            models.User.objects.get(id=user_id).delete()
                            context = {
                                'result': True,
                                'message': '用户删除成功'
                            }
                    except (ValueError, IntegrityError, AttributeError, Exception):
                        context = {
                            'result': False,
                            'message': '用户删除失败'
                        }
                else:
                    context = {
                        'result': False,
                        'message': '权限不足'
                    }
                return HttpResponse(json.dumps(context))
            else:
                return HttpResponseRedirect("/user")
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


@transaction.atomic()
def role(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'role'):
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

            return_value = {
                'roles': role_dict,
                'menus': menus,
                'active': 'role'
            }
            return render(request, 'BroadviewCOSS/role.html', return_value)
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


def role_name_validate(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'role'):
            role_id = request.POST.get('role-id')
            role_name = request.POST.get('role_name')

            if role_id is None or not models.Role.objects.get(id=role_id).name == role_name:
                is_validate = models.Role.objects.filter(name=role_name).exists()
            else:
                is_validate = False

            return HttpResponse(json.dumps(not is_validate))
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


@transaction.atomic()
def role_add(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'role'):
            permissions = models.Permission.objects.all()

            if request.method == 'POST':
                if verify_permission(username, 'update'):
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

                            context = {
                                'result': True,
                                'message': '角色添加成功'
                            }
                    except (ValueError, IntegrityError):
                        context = {
                            'result': False,
                            'message': '角色添加失败'
                        }
                else:
                    context = {
                        'result': False,
                        'message': '权限不足'
                    }

                return HttpResponse(json.dumps(context))
            else:
                return_value = {
                    'menus': menus,
                    'permissions': permissions,
                    'active': 'role'
                }
                return render(request, 'BroadviewCOSS/role-add.html', return_value)
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


@transaction.atomic()
def role_update(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'role'):
            permissions = models.Permission.objects.all()

            if request.method == 'POST':
                if verify_permission(username, 'update'):
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
                else:
                    context = {
                        'result': False,
                        'message': '权限不足'
                    }

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
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


@transaction.atomic()
def role_delete(request):
    username = request.session.get('username', None)
    if username:
        menus = get_menus(username)
        if verify_menus(menus, 'role'):

            if request.method == 'POST':
                if get_permission(username).delete:
                    data = json.loads(request.body)
                    role_id = data['id']

                    try:
                        with transaction.atomic():
                            models.Role.objects.get(id=role_id).delete()
                            context = {'result': True, 'message': '角色删除成功'}
                    except (ValueError, IntegrityError, AttributeError) as e:
                        context = {'result': False, 'message': '角色修改失败'}
                else:
                    context = {
                        'result': False,
                        'message': '权限不足'
                    }

                return HttpResponse(json.dumps(context))
            else:
                return HttpResponseRedirect("/role")
        else:
            raise PermissionDenied
    else:
        return HttpResponseRedirect('/login')


def bad_request(request, exception):
    return render(request, 'BroadviewCOSS/400.html')


def page_not_found(request, exception):
    return render(request, 'BroadviewCOSS/404.html')


def page_error(request, exception):
    return render(request, 'BroadviewCOSS/500.html')


def permission_denied(request, exception):
    return render(request, 'BroadviewCOSS/403.html')


def get_menus(username):
    u = models.User.objects.get(username=username)
    menu_role_list = u.userrole.role.menurole_set.all()

    menus = []
    for menu_role in menu_role_list:
        menus.append(menu_role.menu)

    return menus


def get_permission(username):
    u = models.User.objects.get(username=username)

    permission = u.userrole.role.rolepermission.permission

    return permission


def verify_menus(menus, url):
    self_menu = models.Menu.objects.get(url=url)
    if self_menu in menus:
        return True
    else:
        return False


def verify_permission(username, fun):
    permission = get_permission(username)

    if fun == 'view':
        return permission.view
    elif fun == 'update':
        return permission.update
    elif fun == 'delete':
        return permission.delete
    else:
        return False
