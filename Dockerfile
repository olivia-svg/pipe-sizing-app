# Use Python 3.11 slim image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Expose port 10000 (Render requirement)
EXPOSE 10000

# Run the Streamlit app on Render's required port
CMD streamlit run app.py --server.port=10000 --server.address=0.0.0.0 --server.headless=true --server.fileWatcherType=none