import requests

# URL of the authentication endpoint
auth_url = "https://example.com/authenticate"

# Payload containing credentials or any required parameters
payload = {
    "username": "your_username",
    "password": "your_password"
}

# Send POST request to obtain the token
response = requests.post(auth_url, data=payload)

# Check if the request was successful (status code 200)
if response.status_code == 200:
    # Extract the token from the response JSON
    token = response.json().get("access_token")
    print("Bearer Token:", token)
else:
    print("Failed to obtain bearer token:", response.text)
