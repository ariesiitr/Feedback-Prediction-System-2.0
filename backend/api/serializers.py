from rest_framework import serializers
from api.models import Project, Feedback, Result

class ProjectSerializer(serializers.ModelSerializer):
    class Meta:
        model = Project
        fields = '__all__'

class FeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = Feedback
        fields = '__all__'

class ResultSerializer(serializers.ModelSerializer):
    class Meta:
        model = Result
        fields = '__all__'