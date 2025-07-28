#!/bin/bash

echo "🚀 Setting up Routing CMS..."

# Check if .env already exists
if [ -f ".env" ]; then
    echo "⚠️  .env file already exists. Skipping creation."
else
    echo "📝 Creating .env file from template..."
    cp env.example .env
    echo "✅ .env file created! Please update it with your Firebase configuration."
fi

# Install dependencies
echo "📦 Installing dependencies..."
npm install

echo ""
echo "🎉 Setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Update .env with your Firebase configuration"
echo "2. Set up your Firebase project and Firestore collections"
echo "3. Run 'npm run dev' to start the development server"
echo ""
echo "📚 See README.md for detailed setup instructions" 