import base64
import requests
import os

# Parent API path
API_PATH = "http://example.com/api/"


# Get username and password from environment variables
USERNAME = os.environ.get('API_USERNAME')
PASSWORD = os.environ.get('API_PASSWORD')

# Encode credentials for basic authentication
ENCODED_AUTH_TOKEN = base64.b64encode(f"{USERNAME}:{PASSWORD}".encode()).decode()

# Headers for basic authentication
HEADERS = {
    "Authorization": f"Basic {ENCODED_AUTH_TOKEN}",
    "Content-Type": "application/json"
}

def handle_request(method_name, url, payload, headers):
    try:
        if method_name.lower() in ['get', 'delete']:
            response = getattr(requests, method_name.lower())(url, params=payload, headers=headers)
        else:
            response = getattr(requests, method_name.lower())(url, json=payload, headers=headers)
        print(f"Request successful for {method_name.upper()} request. URL: {url}, Payload: {payload}, Headers: {headers}, Response: {response.json()}")
        return response  # Return the response object
    except Exception as e:
        print(f"Error occurred: {e}")

