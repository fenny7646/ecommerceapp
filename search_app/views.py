from django.shortcuts import render
from ecommerceapp.models import Product
from django.db.models import Q
from django.http import HttpResponse
# Create your views here.

def SearchResult(request):
    # return HttpResponse('Hey, I am here')
    products= None
    query= None
    if 'q' in request.GET:
        query= request.GET.get('q')
        products= Product.objects.all().filter(Q(name__contains= query) | Q(proddesc__contains= query))

        return render(request,"search.html",{'query':query,'products':products})