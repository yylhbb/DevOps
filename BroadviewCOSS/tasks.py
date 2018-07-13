# coding=utf-8
from __future__ import absolute_import

import os
import locale
import platform
import datetime
import re
from subprocess import call, Popen, PIPE
from celery.signals import after_task_publish, task_success, task_postrun

from DevOps import celery_app
from BroadviewCOSS import models


@celery_app.task
def scheduler():
    tr_list = models.TaskRun.objects.filter(status=2)
    for tr in tr_list:
        start_time = tr.start_time
        if start_time <= datetime.datetime.now():
            tr.status = 3
            tr.save()

            host_list = set()
            t_m_list = tr.task.taskmainframe_set.all()
            for t_m in t_m_list:
                host_list.add(t_m.mainframe)

            t_c_list = tr.task.taskcategory_set.all()
            for t_c in t_c_list:
                m_list = models.Mainframe.objects.filter(category=t_c.category)

                for m in m_list:
                    host_list.add(m)

            cmd = tr.task.task
            for host in host_list:
                if host.type == 'Linux':
                    cmd = cmd.replace('\r\n', ';')
                else:
                    cmd = cmd.replace('\r\n', '&')

                ip = host.ip
                command.apply_async(args=(cmd,), queue=ip, link=success.s(ip=ip, tr_id=tr.id),
                                    link_error=failure.s(ip=ip, tr_id=tr.id))


@celery_app.task
def command(cmd):
    pass


@celery_app.task
def success(result, ip, tr_id):
    tr = models.TaskRun.objects.get(id=tr_id)

    old_result = tr.result
    result = '\r\n任务在 ' + ip + ' 上运行完毕：\r\n' + result.__str__()

    tr.result = (old_result + result).strip('\r\n')
    tr.status = 0
    tr.end_time = datetime.datetime.now()
    tr.save()


@celery_app.task
def failure(result, ip, tr_id):
    tr = models.TaskRun.objects.get(id=tr_id)

    old_result = tr.result
    result = '\r\n任务在 ' + ip + ' 上运行失败：\r\n' + result

    tr.result = (old_result + result).strip('\r\n')
    tr.status = 1
    tr.end_time = datetime.datetime.now()
    tr.save()


@celery_app.task
def ping():
    m_list = models.Mainframe.objects.all()

    for m in m_list:
        ip = m.ip

        system = platform.system()
        if system == 'Windows':
            encoding = locale.getdefaultlocale()[1]
            p = Popen(['ping.exe', ip], stdin=PIPE, stdout=PIPE, stderr=PIPE, shell=True)
            out = p.stdout.read().decode(encoding)

            regex = re.compile(r'\w*%\w*')
            r_list = regex.findall(out)
            if r_list:
                r = r_list[0]
                if r == '100%':
                    m.status = 1
                elif r == '0%':
                    m.status = 0

                m.save()
        else:
            status = call('ping -c 1 %s' % ip, stdout=open(os.devnull, 'w'), stderr=open(os.devnull, 'w'))
            if status == 0:
                m.status = 0
            elif status == 1:
                m.status = 1

            m.save()


@task_postrun.connect
def task_send_handler(task_id, task, retval, state, *args, **kwargs):
    print('task_postrun: id={id}; task={task}; agrs={args}; kwargs={kwargs}; retval={retval}; state={state}'.format(
        id=task_id, task=task, args=args, kwargs=kwargs, retval=retval, state=state))
