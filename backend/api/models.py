from django.db import models


class Project(models.Model):
    title = models.CharField(max_length=100)
    description = models.TextField(null=True)
    contributors = models.TextField(null=True)
    startDate = models.DateField(null=True)
    endDate = models.DateField(null=True)


class Feedback(models.Model):
    projectId = models.ForeignKey('Project', on_delete=models.CASCADE)
    visitorName = models.CharField(max_length=60)
    speech = models.TextField()
    date = models.DateField(auto_now_add=True)


class Result(models.Model):
    feedbackId = models.ForeignKey(
        'Feedback', on_delete=models.CASCADE)
    feedbacks = [
        ('Positive', 'Positive'),
        ('Negative', 'Negative'),
        ('Not evaluated', 'Not evaluated')
    ]
    feedback = models.CharField(
        max_length=15, choices=feedbacks, default='Not Evaluated')
    score = models.FloatField(default=0.0)
