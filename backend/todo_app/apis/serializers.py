from rest_framework import serializers
from todos import models

class TodosSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'title',
            'description'
        )
        models = models.Todo