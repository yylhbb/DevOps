# Generated by Django 2.0.4 on 2018-05-22 01:00

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=20)),
                ('description', models.TextField(blank=True)),
            ],
            options={
                'db_table': 'Category',
                'ordering': ['name'],
            },
        ),
        migrations.CreateModel(
            name='Mainframe',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('ip', models.GenericIPAddressField()),
                ('hostname', models.CharField(max_length=30)),
                ('status', models.PositiveIntegerField(choices=[('0', '正常'), ('1', '无法连接')], default=0)),
                ('description', models.TextField(blank=True)),
                ('category', models.ForeignKey(db_column='category', default=0, on_delete=django.db.models.deletion.SET_DEFAULT, to='BroadviewCOSS.Category')),
            ],
            options={
                'db_table': 'Mainframe',
            },
        ),
        migrations.CreateModel(
            name='Menu',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=20)),
                ('parent', models.PositiveIntegerField(default=0)),
                ('sub', models.PositiveIntegerField(default=0)),
                ('url', models.CharField(blank=True, default='', max_length=100)),
                ('icon', models.CharField(blank=True, default='', max_length=20)),
                ('index', models.PositiveIntegerField(default=0)),
            ],
            options={
                'db_table': 'Menu',
                'ordering': ['index'],
            },
        ),
        migrations.CreateModel(
            name='MenuRole',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('menu', models.ForeignKey(db_column='menu', on_delete=django.db.models.deletion.CASCADE, to='BroadviewCOSS.Menu')),
            ],
            options={
                'db_table': 'MenuRole',
            },
        ),
        migrations.CreateModel(
            name='OperationLog',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.CharField(max_length=100)),
                ('time', models.DateTimeField(auto_now_add=True)),
            ],
            options={
                'db_table': 'OperationLog',
            },
        ),
        migrations.CreateModel(
            name='Permission',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('view', models.BooleanField(default=True)),
                ('update', models.BooleanField(default=False)),
                ('delete', models.BooleanField(default=False)),
            ],
            options={
                'db_table': 'Permission',
            },
        ),
        migrations.CreateModel(
            name='Role',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=20, unique=True)),
                ('description', models.TextField(blank=True)),
            ],
            options={
                'db_table': 'Role',
                'ordering': ['id'],
            },
        ),
        migrations.CreateModel(
            name='RolePermission',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('permission', models.ForeignKey(db_column='permission', on_delete=django.db.models.deletion.CASCADE, to='BroadviewCOSS.Permission')),
                ('role', models.OneToOneField(db_column='role', on_delete=django.db.models.deletion.CASCADE, to='BroadviewCOSS.Role')),
            ],
            options={
                'db_table': 'RolePermission',
            },
        ),
        migrations.CreateModel(
            name='Task',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('description', models.TextField(blank=True)),
                ('task', models.TextField()),
                ('create_date', models.DateTimeField(auto_now_add=True)),
                ('last_update', models.DateTimeField(auto_now=True)),
                ('category', models.ForeignKey(db_column='category', null=True, on_delete=django.db.models.deletion.SET_NULL, to='BroadviewCOSS.Category')),
                ('mainframe', models.ForeignKey(db_column='mainframe', null=True, on_delete=django.db.models.deletion.SET_NULL, to='BroadviewCOSS.Mainframe')),
            ],
            options={
                'db_table': 'Task',
            },
        ),
        migrations.CreateModel(
            name='TaskRun',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('start_time', models.DateTimeField()),
                ('end_time', models.DateTimeField(null=True)),
                ('status', models.PositiveIntegerField(choices=[('0', '成功'), ('1', '失败'), ('2', '等待执行')], default=2)),
                ('result', models.TextField(blank=True)),
                ('task', models.ForeignKey(db_column='task', on_delete=django.db.models.deletion.CASCADE, to='BroadviewCOSS.Task')),
            ],
            options={
                'db_table': 'TaskRun',
            },
        ),
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('username', models.CharField(max_length=20, unique=True)),
                ('password', models.CharField(max_length=20)),
                ('last_login', models.DateTimeField(auto_now=True, null=True)),
                ('is_active', models.BooleanField()),
            ],
            options={
                'db_table': 'User',
            },
        ),
        migrations.CreateModel(
            name='UserRole',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('role', models.ForeignKey(db_column='role', on_delete=django.db.models.deletion.CASCADE, to='BroadviewCOSS.Role')),
                ('user', models.OneToOneField(db_column='user', on_delete=django.db.models.deletion.CASCADE, to='BroadviewCOSS.User')),
            ],
            options={
                'db_table': 'UserRole',
            },
        ),
        migrations.AddField(
            model_name='taskrun',
            name='user',
            field=models.ForeignKey(db_column='user', null=True, on_delete=django.db.models.deletion.SET_NULL, to='BroadviewCOSS.User'),
        ),
        migrations.AddField(
            model_name='task',
            name='user',
            field=models.ForeignKey(db_column='user', null=True, on_delete=django.db.models.deletion.SET_NULL, to='BroadviewCOSS.User'),
        ),
        migrations.AddField(
            model_name='operationlog',
            name='user',
            field=models.ForeignKey(db_column='user', on_delete=django.db.models.deletion.DO_NOTHING, to='BroadviewCOSS.User'),
        ),
        migrations.AddField(
            model_name='menurole',
            name='role',
            field=models.ForeignKey(db_column='role', on_delete=django.db.models.deletion.CASCADE, to='BroadviewCOSS.Role'),
        ),
    ]
