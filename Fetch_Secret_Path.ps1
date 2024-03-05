# Define the URL of your vault's API endpoint
$vaultUrl = "https://yourvault.com/api/v1"

# Define the static role ID and client token
$roleId = "yourRoleId"
$clientToken = "yourClientToken"

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

# Construct the API request URL to fetch the secret paths
$secretPathsRequestUrl = "$vaultUrl/v1/secret/metadata"

# Update headers with the secret token
$headers["X-Vault-Token"] = $secretToken

# Make a GET request to fetch the secret paths
$secretPathsResponse = Invoke-RestMethod -Uri $secretPathsRequestUrl -Method Get -Headers $headers

# Extract the secret paths from the response
$secretPaths = $secretPathsResponse.data.keys

# Display the secret paths
Write-Host "Secret Paths:"
foreach ($path in $secretPaths) {
    Write-Host "- $path"
}
