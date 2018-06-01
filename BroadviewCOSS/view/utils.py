from django.http import HttpResponseRedirect

from BroadviewCOSS import models


def check_access(request, url):
    username = request.session.get('username', None)
    if username:
        if check_menus(username, url):
            return True
        else:
            raise PermissionError
    else:
        return False


def check_menus(username, url):
    menus = get_menus(username)
    s_menu = models.Menu.objects.filter(url=url)

    if not menus:
        return False

    if s_menu.exists():
        s_menu = s_menu.get()
        if s_menu in menus:
            return True
        else:
            return False


def get_menus(username):
    menus = []

    u = get_user(username)
    if u:
        m_r_list = u.userrole.role.menurole_set.all()

        if m_r_list.exists():
            for m_r in m_r_list:
                menus.append(m_r.menu)

    return menus


def get_permission(username, action):
    u = get_user(username)
    if u:
        p = u.userrole.role.rolepermission.permission

        return {
            'view': p.view,
            'update': p.update,
            'delete': p.delete
        }.get(action)

    return False


def get_user(username):
    u = models.User.objects.filter(username=username)

    if u.exists():
        return u.get()
    else:
        return None
