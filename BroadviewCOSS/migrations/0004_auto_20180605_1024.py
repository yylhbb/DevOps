# Generated by Django 2.0.4 on 2018-06-05 10:24

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('BroadviewCOSS', '0003_auto_20180605_1010'),
    ]

    operations = [
        migrations.AlterField(
            model_name='task',
            name='create_date',
            field=models.DateTimeField(null=True),
        ),
        migrations.AlterField(
            model_name='task',
            name='last_update',
            field=models.DateTimeField(null=True),
        ),
    ]
