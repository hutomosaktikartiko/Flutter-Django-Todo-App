from django.shortcuts import render

# Create your views here.
from todos import models
from .serializers import TodosSerializer

class ListTodo(generics.ListCreateAPIView):
    queryset = models.object.all()
    serializer_class = TodosSerializer

class DetailTodo(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.object.all()
    serialzer_class = TodosSerializer