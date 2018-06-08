from django.db import models


class Role(models.Model):
    name = models.CharField(max_length=20, unique=True)
    description = models.TextField(blank=True)

    class Meta:
        db_table = 'Role'
        ordering = ['id']


class User(models.Model):
    username = models.CharField(unique=True, max_length=20)
    password = models.CharField(max_length=20)
    last_login = models.DateTimeField(null=True)
    is_active = models.BooleanField()

    class Meta:
        db_table = 'User'
        ordering = ['id']


class UserRole(models.Model):
    user = models.OneToOneField(User, db_column='user', on_delete=models.CASCADE, )
    role = models.ForeignKey(Role, db_column='role', on_delete=models.CASCADE, )

    class Meta:
        db_table = 'UserRole'
        ordering = ['id']


class Menu(models.Model):
    name = models.CharField(max_length=20)
    parent = models.PositiveIntegerField(default=0)
    sub = models.PositiveIntegerField(default=0)
    url = models.CharField(max_length=100, blank=True, default='')
    icon = models.CharField(max_length=20, blank=True, default='')
    index = models.PositiveIntegerField(default=0)

    class Meta:
        db_table = 'Menu'
        ordering = ['index']


class MenuRole(models.Model):
    menu = models.ForeignKey(Menu, db_column='menu', on_delete=models.CASCADE, )
    role = models.ForeignKey(Role, db_column='role', on_delete=models.CASCADE, )

    class Meta:
        db_table = 'MenuRole'


class Permission(models.Model):
    view = models.BooleanField(default=True)
    update = models.BooleanField(default=False)
    delete = models.BooleanField(default=False)

    class Meta:
        db_table = 'Permission'

    def __str__(self):
        p_str = ""
        if self.view:
            p_str += "查看,"

        if self.update:
            p_str += "修改,"

        if self.delete:
            p_str += "删除,"

        return p_str.strip(",")


class RolePermission(models.Model):
    role = models.OneToOneField(Role, db_column='role', on_delete=models.CASCADE, )
    permission = models.ForeignKey(Permission, db_column='permission', on_delete=models.CASCADE, )

    class Meta:
        db_table = 'RolePermission'


class Category(models.Model):
    name = models.CharField(max_length=20)
    description = models.TextField(blank=True)

    class Meta:
        db_table = 'Category'
        ordering = ['id']


class Mainframe(models.Model):
    STATUS_CHOICE = (
        (0, '正常'),
        (1, '无法连接'),
        (2, '未知')
    )
    ip = models.GenericIPAddressField()
    host = models.PositiveIntegerField(default=9876)
    hostname = models.CharField(max_length=30)
    category = models.ForeignKey(Category, default=0, db_column='category', on_delete=models.SET_DEFAULT, )
    status = models.PositiveIntegerField(default=0, choices=STATUS_CHOICE)
    description = models.TextField(blank=True)

    class Meta:
        db_table = 'Mainframe'
        ordering = ['id']


class Task(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True)
    task = models.TextField()
    create_date = models.DateTimeField(auto_now_add=True)
    last_update = models.DateTimeField(auto_now=True)
    user = models.ForeignKey(User, null=True, db_column='user', on_delete=models.SET_NULL, )

    class Meta:
        db_table = 'Task'
        ordering = ['last_update']


class TaskCategory(models.Model):
    task = models.ForeignKey(Task, db_column='task', on_delete=models.CASCADE, )
    category = models.ForeignKey(Category, db_column='category', on_delete=models.CASCADE, )

    class Meta:
        db_table = 'TaskCategory'


class TaskMainframe(models.Model):
    task = models.ForeignKey(Task, db_column='task', on_delete=models.CASCADE, )
    mainframe = models.ForeignKey(Mainframe, db_column='mainframe', on_delete=models.CASCADE, )

    class Meta:
        db_table = 'TaskMainframe'


class TaskRun(models.Model):
    TASK_RUN_STATUS = (
        ('0', '成功'),
        ('1', '失败'),
        ('2', '等待执行')
    )
    task = models.ForeignKey(Task, db_column='task', on_delete=models.CASCADE, )
    start_time = models.DateTimeField()
    end_time = models.DateTimeField(null=True)
    status = models.PositiveIntegerField(default=2, choices=TASK_RUN_STATUS)
    result = models.TextField(blank=True)
    user = models.ForeignKey(User, null=True, db_column='user', on_delete=models.SET_NULL, )

    class Meta:
        db_table = 'TaskRun'


class OperationLog(models.Model):
    user = models.ForeignKey(User, db_column='user', on_delete=models.DO_NOTHING, )
    content = models.CharField(max_length=100)
    time = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = 'OperationLog'
