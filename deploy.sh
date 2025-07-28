#!/bin/bash

echo "🚀 Deploying Routing CMS to Firebase Hosting..."

# Check if Firebase CLI is installed
if ! command -v firebase &> /dev/null; then
    echo "📦 Installing Firebase CLI..."
    npm install -g firebase-tools
fi

# Check if user is logged in
if ! firebase projects:list &> /dev/null; then
    echo "🔐 Please login to Firebase..."
    firebase login
fi

# Build the application
echo "🔨 Building application..."
npm run build

if [ $? -ne 0 ]; then
    echo "❌ Build failed! Please fix the errors and try again."
    exit 1
fi

# Deploy to Firebase
echo "🌐 Deploying to Firebase Hosting..."
firebase deploy --only hosting

if [ $? -eq 0 ]; then
    echo ""
    echo "🎉 Deployment successful!"
    echo ""
    echo "📋 Your app is now live at:"
    echo "   https://$(firebase projects:list --json | grep -o '"projectId":"[^"]*"' | cut -d'"' -f4).web.app"
    echo ""
    echo "🔗 You can also access it at:"
    echo "   https://$(firebase projects:list --json | grep -o '"projectId":"[^"]*"' | cut -d'"' -f4).firebaseapp.com"
    echo ""
    echo "📖 For more deployment options, see DEPLOYMENT.md"
else
    echo "❌ Deployment failed! Please check the error messages above."
    exit 1
fi 