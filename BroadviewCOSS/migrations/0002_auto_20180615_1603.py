# Generated by Django 2.0.4 on 2018-06-15 16:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('BroadviewCOSS', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='mainframe',
            name='host',
        ),
        migrations.AddField(
            model_name='mainframe',
            name='type',
            field=models.CharField(default='Linux', max_length=30),
        ),
    ]