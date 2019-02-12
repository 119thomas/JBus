from django.shortcuts import render
from django.http import HttpResponse
from django.views.generic import TemplateView, ListView
import requests
import xml.etree.ElementTree as ET
from .models import Route, Stop
# Create your views here.


class IndexView(TemplateView):
    template_name = 'index.html'


class RouteListView(ListView):
    template_name = 'route_list.html'
    model = Route
    'http://webservices.nextbus.com/service/publicXMLFeed?command=routeConfig&a=umd&r='


def init_routes():

    res = requests.get(
        'http://webservices.nextbus.com/service/publicXMLFeed?command=routeList&a=umd')
    routes = ET.fromstring(res.text)
    for route in routes:
        r = Route(tag=route.get('tag'), title=route.get(
            'title'), short_title=route.get('shortTitle'))
        r.save()


def init_stops():

    for route in Route.objects.all():
        res = requests.get(
            'http://webservices.nextbus.com/service/publicXMLFeed?command=routeConfig&a=umd&r={}'.format(
                route.tag)
        )
        root = ET.fromstring(res.text)
        route.stops.clear()
        for stop in root.findall('.//stop'):
            if (stop.get('title')):
                s = Stop(tag=stop.get('tag'), title=stop.get('title'),
                         lat=stop.get('lat'),
                         lon=stop.get('lon'),
                         stopId=stop.get('stopId'))
                s.save()
                route.stops.add(s)
        route.save()
    print('done')


# init_routes()
# init_stops()
