#!/bin/bash

# Google Cloud Run Deployment Script for Pipe Sizing App
# Make sure you have gcloud CLI installed and authenticated

echo "🚀 Deploying Pipe Sizing App to Google Cloud Run..."

# Set your project ID here
PROJECT_ID="your-project-id-here"
SERVICE_NAME="pipe-sizing-app"
REGION="us-central1"

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    echo "❌ gcloud CLI is not installed. Please install it first:"
    echo "   https://cloud.google.com/sdk/docs/install"
    exit 1
fi

# Set the project
echo "📝 Setting project to: $PROJECT_ID"
gcloud config set project $PROJECT_ID

# Enable required APIs
echo "🔧 Enabling required APIs..."
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable containerregistry.googleapis.com

# Build and deploy using Cloud Build
echo "🏗️  Building and deploying..."
gcloud builds submit --config cloudbuild.yaml

# Get the service URL
echo "🌐 Getting service URL..."
SERVICE_URL=$(gcloud run services describe $SERVICE_NAME --region=$REGION --format="value(status.url)")

echo "✅ Deployment complete!"
echo "🔗 Your app is available at: $SERVICE_URL"
echo ""
echo "📋 Next steps:"
echo "   1. Update PROJECT_ID in this script with your actual Google Cloud project ID"
echo "   2. Run: chmod +x deploy.sh && ./deploy.sh"
echo "   3. Visit your app at the URL above"