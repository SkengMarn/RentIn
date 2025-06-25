# api/views.py
from django.http import JsonResponse

def test_api(request):
    return JsonResponse({"status": "success", "message": "Hello from RentIn API"})
