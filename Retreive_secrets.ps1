# Define the URL of your vault's API endpoint
$vaultUrl = "https://yourvault.com/api/v1"

# Define the static role ID and client token
$roleId = "yourRoleId"
$clientToken = "yourClientToken"

# Define the secret path from which to retrieve secrets
$secretPath = "/secrets/myapp/database-password"

# Create the authorization header with the client token
$headers = @{
    "X-Vault-Token" = $clientToken
}

# Construct the API request URL for authentication
$authRequestUrl = "$vaultUrl/auth/approle/login"

# Define the payload for the login request
$payload = @{
    "role_id" = $roleId
}

# Convert the payload to JSON
$jsonPayload = $payload | ConvertTo-Json

# Make the POST request to authenticate and obtain a secret token
$response = Invoke-RestMethod -Uri $authRequestUrl -Method Post -Headers $headers -Body $jsonPayload

# Extract the secret token from the response
$secretToken = $response.auth.client_token

# Construct the API request URL to fetch secrets from the specified path
$secretRequestUrl = "$vaultUrl$secretPath"

# Update headers with the secret token
$headers["X-Vault-Token"] = $secretToken

# Make a GET request to fetch secrets from the specified path
$secretResponse = Invoke-RestMethod -Uri $secretRequestUrl -Method Get -Headers $headers

# Extract the secret value from the response
$secretValue = $secretResponse.data.value

# Display the retrieved secret value
Write-Host "Secret Value: $secretValue"
