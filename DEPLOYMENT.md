# Deployment Guide - Firebase Hosting

This guide will help you deploy the Routing CMS to Firebase Hosting for a live demo URL.

## 🚀 Quick Deploy

### **Option 1: One-Click Deploy (Recommended)**

1. **Install Firebase CLI** (if not already installed):

   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase**:

   ```bash
   npm run firebase:login
   ```

3. **Initialize Firebase Hosting**:

   ```bash
   npm run firebase:init
   ```

   - Select your Firebase project
   - Use `dist` as your public directory
   - Configure as a single-page app: **Yes**
   - Don't overwrite `index.html`: **No**

4. **Deploy to Firebase**:
   ```bash
   npm run deploy
   ```

### **Option 2: Manual Setup**

1. **Install Firebase CLI**:

   ```bash
   npm install -g firebase-tools
   ```

2. **Login and Initialize**:

   ```bash
   firebase login
   firebase init hosting
   ```

3. **Build and Deploy**:
   ```bash
   npm run build
   firebase deploy
   ```

## 🔧 Configuration Files

### **firebase.json**

```json
{
  "hosting": {
    "public": "dist",
    "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ],
    "headers": [
      {
        "source": "**/*.@(js|css)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=31536000"
          }
        ]
      }
    ]
  }
}
```

### **.firebaserc**

```json
{
  "projects": {
    "default": "your-firebase-project-id"
  }
}
```

## 🌐 Environment Variables for Production

### **Setting Environment Variables**

For production deployment, you'll need to set environment variables in Firebase:

1. **Go to Firebase Console** → Your Project → Settings → General
2. **Add environment variables** in the hosting configuration
3. **Or use Firebase Functions** for server-side environment variables

### **Alternative: Build-time Environment Variables**

You can also set environment variables during build:

```bash
VITE_FIREBASE_API_KEY=your-key npm run build
```

## 📋 Deployment Checklist

### **Pre-Deployment**

- [ ] Firebase CLI installed and logged in
- [ ] Firebase project created and configured
- [ ] Firestore collections set up (`routes` and `pages`)
- [ ] Environment variables configured
- [ ] Application builds successfully locally

### **Deployment Steps**

- [ ] Run `npm run build` (creates `dist` folder)
- [ ] Run `firebase deploy` (deploys to Firebase Hosting)
- [ ] Verify deployment URL works
- [ ] Test all functionality on live site

### **Post-Deployment**

- [ ] Test navigation and routing
- [ ] Test Admin interface
- [ ] Test real-time updates
- [ ] Verify Firebase connections

## 🔍 Troubleshooting

### **Common Issues**

| Issue                           | Solution                                                   |
| ------------------------------- | ---------------------------------------------------------- |
| "Build failed"                  | Check for syntax errors, run `npm run build` locally first |
| "Firebase not found"            | Install Firebase CLI: `npm install -g firebase-tools`      |
| "Project not found"             | Update `.firebaserc` with correct project ID               |
| "Environment variables missing" | Set up environment variables in Firebase Console           |
| "404 errors on routes"          | Ensure `rewrites` are configured in `firebase.json`        |

### **Debug Commands**

```bash
# Check Firebase project
firebase projects:list

# Check hosting configuration
firebase hosting:channel:list

# View deployment logs
firebase hosting:releases:list

# Test locally
firebase serve
```

## 🎯 Deployment URLs

After successful deployment, your app will be available at:

- **Production**: `https://your-project-id.web.app`
- **Preview**: `https://your-project-id.firebaseapp.com`

## 🔄 Continuous Deployment

### **GitHub Actions (Optional)**

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Firebase
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v2
        with:
          node-version: "18"
      - run: npm install
      - run: npm run build
      - uses: FirebaseExtended/action-hosting-deploy@v0
        with:
          repoToken: "${{ secrets.GITHUB_TOKEN }}"
          firebaseServiceAccount: "${{ secrets.FIREBASE_SERVICE_ACCOUNT }}"
          projectId: your-project-id
```

## 📊 Performance Optimization

### **Build Optimization**

- Assets are automatically minified
- CSS and JS are optimized for production
- Static assets are cached with proper headers

### **Firebase Hosting Features**

- Global CDN for fast loading
- Automatic HTTPS
- Custom domains support
- A/B testing capabilities

## 🔒 Security Considerations

### **Environment Variables**

- Never commit `.env` files to Git
- Use Firebase Console for production environment variables
- Consider using Firebase Functions for sensitive data

### **Firebase Security Rules**

Ensure your Firestore security rules are production-ready:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /routes/{document} {
      allow read: if true;
      allow write: if request.auth != null;
    }
    match /pages/{document} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

---

**🎉 Your Routing CMS will be live at: `https://your-project-id.web.app`**
