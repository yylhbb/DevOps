# coding=utf-8
from django.urls import path
from BroadviewCOSS import views

app_name = 'BroadviewCOSS'
urlpatterns = [
    path('', views.index),
    path('index/', views.index, name='index'),
    path('login/', views.login, name='login'),
    path('mainframe/', views.mainframe, name='mainframe'),
    path('task/', views.task, name='task'),
    path('category/', views.category, name='category'),
    path('user/', views.user, name='user'),
    path('user/show', views.show_user, name='show-user'),
    path('user/add', views.user_add, name='add-user'),
    path('user/validate', views.user_name_validate, name='user-name-validate'),
    path('role/', views.role, name='role'),
    path('role/add/', views.role_add, name='add-role'),
    path('role/update/', views.role_update, name='update-role'),
    path('role/delete', views.role_delete, name='delete-role'),
    path('role/validate', views.role_name_validate, name='role-name-validate'),
]