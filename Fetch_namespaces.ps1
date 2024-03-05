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

# Construct the API request URL to fetch the vault namespace
$namespaceRequestUrl = "$vaultUrl/v1/sys/internal/ui/mounts"

# Update headers with the secret token
$headers["X-Vault-Token"] = $secretToken

# Make a GET request to fetch the vault namespace
$namespaceResponse = Invoke-RestMethod -Uri $namespaceRequestUrl -Method Get -Headers $headers

# Parse the response to extract the vault namespace
$vaultNamespace = $namespaceResponse.data | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name

# Display the vault namespace
Write-Host "Vault Namespace: $vaultNamespace"
