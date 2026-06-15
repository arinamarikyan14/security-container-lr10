from django.contrib import admin
from django.urls import path
from security import views


urlpatterns = [
    path("admin/", admin.site.urls),
    path("", views.index, name="index"),
    path("security/", views.index, name="security"),
    path("metrics/", views.metrics_view, name="metrics"),
]
