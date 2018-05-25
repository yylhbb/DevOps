# coding=utf-8
from django.urls import path
from BroadviewCOSS import views

app_name = 'BroadviewCOSS'
urlpatterns = [
    path('login/', views.login, name='login'),
    path('index/', views.index, name='index'),
    path('mainframe/', views.mainframe, name='mainframe'),
    path('task/', views.task, name='task'),
    path('category/', views.category, name='category'),
    path('user/', views.user, name='user'),
    path('role/', views.role, name='role'),
    path('role/add/', views.role_add, name='add-role'),
    path('role/update/', views.role_update, name='update-role'),
    path('role/validate', views.role_name_validate, name='role-name-validate'),
]