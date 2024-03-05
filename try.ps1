# Define your Vault address and token
$vaultAddr = "VAULT_ADDR"
$token = "YOUR_VAULT_TOKEN"

# Define the role name
$roleName = "YOUR_ROLE_NAME"

# Define the path to the endpoint for listing Secret IDs
$listPath = "auth/approle/role/$roleName/secret-id-accessors"

# Prepare headers with the Vault token
$headers = @{
    "X-Vault-Token" = $token
}

# Make a request to list Secret ID accessors
$response = Invoke-RestMethod -Uri "$vaultAddr/v1/$listPath" -Headers $headers -Method Get

# Extract the list of Secret ID accessors from the response
$secretIdAccessors = $response.data.keys

# Print the list of Secret ID accessors
foreach ($accessor in $secretIdAccessors) {
    Write-Output $accessor
}
