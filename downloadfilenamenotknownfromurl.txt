import requests
from urllib.parse import urlparse
import os

# URL of the PDF file
url = 'http://www.example.com/path/to/file'

# Send a GET request to the URL
response = requests.get(url, stream=True)

# Function to extract filename from URL
def get_filename_from_url(url):
    parsed_url = urlparse(url)
    return os.path.basename(parsed_url.path)

# Function to extract filename from Content-Disposition header
def get_filename_from_cd(cd):
    if not cd:
        return None
    fname = None
    for part in cd.split(';'):
        if 'filename=' in part:
            fname = part.split('=')[1].strip('\"')
            break
    return fname

# Determine the filename
filename = get_filename_from_cd(response.headers.get('Content-Disposition'))

if not filename:
    filename = get_filename_from_url(url)

# Check if the request was successful
if response.status_code == 200:
    # Open a local file with write-binary mode using the determined filename
    with open(filename, 'wb') as file:
        for chunk in response.iter_content(chunk_size=8192):
            file.write(chunk)
    print(f"PDF file has been downloaded successfully as {filename}.")
else:
    print(f"Failed to download the PDF file. Status code: {response.status_code}")
