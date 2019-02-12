from django.urls import path
from .views import IndexView, RouteListView


urlpatterns = [
    path('', IndexView.as_view(), name='index'),
    path('routes/', RouteListView.as_view(), name='route_list'),
]
