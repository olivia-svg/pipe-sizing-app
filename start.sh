#!/bin/bash

# Start script for Render deployment
echo "Starting Pipe Sizing App on Render..."

# Install dependencies if needed
pip install -r requirements.txt

# Start Streamlit app
streamlit run app.py --server.port=${PORT:-10000} --server.address=0.0.0.0 --server.headless=true --server.fileWatcherType=none