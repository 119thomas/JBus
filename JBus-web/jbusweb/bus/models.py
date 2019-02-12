from django.db import models

# Create your models here.


class Stop(models.Model):
    tag = models.CharField(max_length=255)
    title = models.CharField(max_length=255)
    lat = models.DecimalField(max_digits=15, decimal_places=7)
    lon = models.DecimalField(max_digits=15, decimal_places=7)
    stopId = models.IntegerField(null=True, blank=True)

    def __str__(self):
        return self.title


class Route(models.Model):
    title = models.CharField(max_length=255)
    tag = models.CharField(max_length=255)
    short_title = models.CharField(max_length=255, null=True, blank=True)
    stops = models.ManyToManyField(Stop)

    def __str__(self):
        return self.title
