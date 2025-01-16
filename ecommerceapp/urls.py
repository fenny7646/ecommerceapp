from django.urls import path,include
from . import views

app_name='ecommerceapp'

urlpatterns = [
    path('', views.allProdCat, name='allProdCat'),
    #path('', views.Basepoint, name='Basepoint'),
    path('<slug:c_slug>/', views.allProdCat, name= 'products_by_category'),
    path('<slug:c_slug>/<slug:product_slug>/', views.proDetail, name= 'prodCatdetail'),
]
