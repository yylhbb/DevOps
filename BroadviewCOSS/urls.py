# coding=utf-8
from django.urls import path
from BroadviewCOSS import views

app_name = 'BroadviewCOSS'
urlpatterns = [
    path('', views.index),
    path('index/', views.index, name='index'),
    path('login/', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
    path('mainframe/', views.mainframe, name='mainframe'),
    path('mainframe/validate', views.mainframe_ip_validate, name='mainframe-ip-validate'),
    path('mainframe/add', views.mainframe_add, name='add-mainframe'),
    path('mainframe/update', views.mainframe_update, name='update-mainframe'),
    path('mainframe/delete', views.mainframe_delete, name='delete-mainframe'),
    path('task/', views.task, name='task'),
    path('task/validate', views.task_name_validate, name='task-name-validate'),
    path('task/add', views.task_add, name='add-task'),
    path('task/update', views.task_update, name='update-task'),
    path('task/delete', views.task_delete, name='delete-task'),
    path('category/', views.category, name='category'),
    path('category/validate', views.category_name_validate, name='category-name-validate'),
    path('category/add', views.category_add, name='add-category'),
    path('category/update', views.category_update, name='update-category'),
    path('category/delete', views.category_delete, name='delete-category'),
    path('user/', views.user, name='user'),
    path('user/add', views.user_add, name='add-user'),
    path('user/update', views.user_update, name='update-user'),
    path('user/delete', views.user_delete, name='delete-user'),
    path('user/validate', views.user_name_validate, name='user-name-validate'),
    path('role/', views.role, name='role'),
    path('role/add/', views.role_add, name='add-role'),
    path('role/update/', views.role_update, name='update-role'),
    path('role/delete', views.role_delete, name='delete-role'),
    path('role/validate', views.role_name_validate, name='role-name-validate'),
]
