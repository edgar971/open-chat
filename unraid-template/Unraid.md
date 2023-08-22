# OpenChat Installation Guide

## Introduction

OpenChat is a self-hosted chatbot that uses Open Source Language Model (LLM) support, providing a private and offline chat experience. This guide will walk you through the installation process using Unraid.


## Installation Steps
1. Search for OpenChat Cuda or OpenChat on the Unraid app store. 
1. Click install. 
1. Review and configure the following settings in the template:
   - **Name**: Choose a name for your OpenChat container.
   - **Repository**: `ghcr.io/edgar971/open-chat-cuda:latest`
   - **Network**: Choose your preferred network mode (e.g., "Bridge").
   - **Web UI Port**: Configure the port for the Chat UI (e.g., 3000).
   - **API Port**: Configure the port for the HTTP API (e.g., 8000).
   - **Number Of GPU Layers**: Customize the number of GPU layers if needed.
   - **Model Directory**: Set the local model directory path.
   - **Local Model Path**: Configure the path to the local model.
   - **Default Model UI**: Set the default model for the UI.
   - **Model Download URL**: Specify the URL for the GGML model binary.
   
   Ensure that the paths and ports do not conflict with existing services on your server.

2. Click "Apply" to save the container settings and start the service.
3. After saving the settings, go back to the Docker tab.

### Step 4: Access OpenChat

Once the container is started, you can access OpenChat by opening a web browser and entering the following URL: http://[Your_Unraid_Server_IP]:[Web_UI_Port]

Replace `[Your_Unraid_Server_IP]` with your Unraid server's IP address and `[Web_UI_Port]` with the configured Web UI port (e.g., 3000).


## Support

For support and troubleshooting, visit the [GitHub project](https://github.com/edgar971/open-chat) or consult the Unraid community.

That's it! You've successfully installed OpenChat on your Unraid server. Enjoy your private and offline chatbot experience!