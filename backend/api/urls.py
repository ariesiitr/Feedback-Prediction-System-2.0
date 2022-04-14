
from django.urls import path, include
from api.views import ProjectViewSet, FeedbackViewSet, ResultViewSet
from rest_framework.routers import DefaultRouter

router = DefaultRouter(trailing_slash=False)
router.register(r'project', ProjectViewSet, basename="project")
router.register(r'feedback', FeedbackViewSet, basename="feedback")
router.register(r'result', ResultViewSet, basename="result")

urlpatterns = [
    path('', include(router.urls)),
]
