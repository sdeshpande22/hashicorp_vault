import requests

def generate_auth_token(username, password):
    # Example authentication endpoint
    auth_endpoint = "https://example.com/authenticate"
    
    # Example payload with username and password
    payload = {
        "username": username,
        "password": password
    }

    try:
        # Make a request to authenticate
        response = requests.post(auth_endpoint, json=payload)
        response.raise_for_status()  # Raise an exception for 4xx and 5xx status codes
        
        # Extract the authentication token from the response
        auth_token = response.json().get("token")
        if auth_token:
            return auth_token
        else:
            raise ValueError("Authentication token not found in response")
    
    except requests.exceptions.RequestException as e:
        print("Error occurred during authentication:", e)
        return None

def test_authenticated_api(auth_token):
    # Example API endpoint
    api_endpoint = "https://api.example.com"

    # Example payload
    payload = {
        "param1": "value1",
        "param2": "value2"
    }

    # Example headers with authentication token
    headers = {
        "Authorization": f"Bearer {auth_token}",
        "Content-Type": "application/json"
    }

    # Make a request with authentication
    response = requests.post(api_endpoint, json=payload, headers=headers)

    # Example assertion
    assert response.status_code == 200, f"Request failed with status code {response.status_code}"

# Example usage:
username = input("Enter your username: ")
password = input("Enter your password: ")

auth_token = generate_auth_token(username, password)
if auth_token:
    test_authenticated_api(auth_token)
else:
    print("Authentication failed.")
