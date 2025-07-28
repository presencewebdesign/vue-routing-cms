# Routing CMS - Vue.js + Firebase

[![Live Demo](https://img.shields.io/badge/Live%20Demo-🌐%20Try%20It%20Now-blue?style=for-the-badge&logo=firebase)](https://routing-cms.web.app)

> **🌐 Live Demo**: [https://routing-cms.web.app](https://routing-cms.web.app)

A dynamic CMS-controlled routing system built with Vue.js 3 and Firebase Firestore. This application demonstrates how to create a content management system that can control routing, page content, and navigation in real-time.

## 🎯 Overview

This project showcases a modern approach to CMS-driven routing where:

- **Routes are controlled by Firebase Firestore** - No code changes needed for redirects
- **Pages are created and managed through the CMS** - Dynamic page creation and content management
- **Real-time updates** - Changes in the database are reflected immediately across all clients
- **Component-based architecture** - Reusable components for easy maintenance

## 🚀 Live Demo

**Try it out**: [https://routing-cms.web.app](https://routing-cms.web.app)

> **💡 Want your own demo?** Run `./deploy.sh` to deploy your own version!

### **What You Can Demo:**

#### **Dynamic Routing**

- Navigate to different pages (About, Contact, Products, Services)
- Go to Admin → Route Management
- Create a redirect rule (e.g., `/about` → `/services`)
- Watch real-time redirects happen instantly!

#### **Page Management**

- Go to Admin → Page Management
- Create new pages with custom components
- Edit existing pages through the modal interface
- Control navigation visibility and order
- See changes reflected immediately in the header
- Use the "🔄 Reset to Defaults" button to restore original demo setup

#### **Real-time Updates**

- Open the demo in multiple browser tabs
- Make changes in the Admin interface
- Watch updates appear instantly across all tabs
- No page refreshes needed!

#### **Component System**

- Dynamic component rendering based on CMS data
- Reusable component architecture
- Consistent styling and behavior
- Easy to extend with new components

## 🏗️ Project Structure

```
routing-cms/
├── src/
│   ├── components/
│   │   ├── DynamicComponents/          # CMS-controlled page components
│   │   │   ├── About.vue              # About page component
│   │   │   ├── Contact.vue            # Contact page component
│   │   │   ├── Products.vue           # Products page component
│   │   │   ├── Services.vue           # Services page component
│   │   │   ├── index.js               # Exports all dynamic components
│   │   │   └── README.md              # Dynamic components documentation
│   │   ├── Admin.vue                  # Admin dashboard with tabs
│   │   ├── ComponentSelector.vue      # Reusable component dropdown
│   │   ├── DynamicPage.vue            # Dynamic page renderer
│   │   ├── Home.vue                   # Home page component
│   │   ├── NotFound.vue               # 404 page component
│   │   ├── PageForm.vue               # Reusable page form
│   │   ├── PageLayout.vue             # Reusable page layout wrapper
│   │   └── PageSettings.vue           # Reusable page settings form
│   ├── App.vue                        # Main application component
│   └── main.js                        # Application entry point
├── .env.example                       # Environment variables template
├── .firebaserc                        # Firebase project configuration
├── .gitignore                         # Git ignore rules
├── DEPLOYMENT.md                      # Deployment guide
├── deploy.sh                          # One-command deployment script
├── env.example                        # Environment variables template
├── firebase.json                      # Firebase hosting configuration
├── FIRESTORE_SETUP.md                 # Firestore setup quick reference
├── index.html                         # HTML template
├── package.json                       # Dependencies and scripts
├── setup.sh                           # Automated setup script
├── vite.config.js                     # Vite configuration
└── README.md                          # This file
```

## 🔧 How It Works

### 1. **Dynamic Routing System**

- Routes are stored in Firebase Firestore `routes` collection
- Each route has: `oldPath`, `newPath`, `active` fields
- Real-time listeners detect changes and redirect users automatically
- Works on both page reload and client-side navigation

### 2. **Page Management System**

- Pages are stored in Firebase Firestore `pages` collection
- Each page has: `title`, `path`, `component`, `order`, `visible`, `active` fields
- Navigation is dynamically generated from active and visible pages
- Pages can be created, edited, and managed through the Admin interface

### 3. **Component Architecture**

- **Static Components**: Home, Admin, NotFound (hardcoded routes)
- **Dynamic Components**: About, Contact, Products, Services (CMS-controlled)
- **Reusable Components**: PageLayout, ComponentSelector, PageForm, PageSettings
- **Dynamic Renderer**: DynamicPage component renders any component based on CMS data

### 4. **Admin Dashboard**

- **Page Management Tab**: Create and manage pages with modal editing (default tab)
- **Route Management Tab**: Create and manage redirect rules
- **Reset Functionality**: "🔄 Reset to Defaults" button to restore demo state
- **Real-time Updates**: All changes are reflected immediately
- **User-friendly Interface**: Clean, responsive design with proper validation

## 🚀 Getting Started

### Prerequisites

- Node.js (v16 or higher)
- npm or yarn
- Firebase project with Firestore enabled

### 1. **Clone and Install**

```bash
git clone <repository-url>
cd routing-cms

# Quick setup (recommended)
./setup.sh

# Or manual setup
npm install
```

### 2. **Deploy to Live Demo (Optional)**

Want to deploy your own version? Use the one-command deployment:

```bash
./deploy.sh
```

This will:

- Install Firebase CLI if needed
- Build the application
- Deploy to Firebase Hosting
- Give you a live URL like `https://your-project-id.web.app`

### 3. **Firebase Setup**

1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable Firestore Database
3. Set up Firestore Security Rules:
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /{document=**} {
         allow read, write: if true;  // For demo purposes
       }
     }
   }
   ```
4. Enable Anonymous Authentication (optional, for demo)

### 4. **Configure Firebase**

1. Copy the environment example file:

   ```bash
   cp env.example .env
   ```

2. Update `.env` with your Firebase configuration:
   ```bash
   VITE_FIREBASE_API_KEY=your-api-key
   VITE_FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
   VITE_FIREBASE_PROJECT_ID=your-project-id
   VITE_FIREBASE_STORAGE_BUCKET=your-project.appspot.com
   VITE_FIREBASE_MESSAGING_SENDER_ID=your-sender-id
   VITE_FIREBASE_APP_ID=your-app-id
   ```

**⚠️ Security Note**: The `.env` file is automatically ignored by Git to keep your Firebase credentials secure.

### 5. **Set Up Firestore Collections**

> **💡 Quick Reference**: See `FIRESTORE_SETUP.md` for a complete checklist and troubleshooting guide.

#### **Step 1: Create Collections**

1. Go to your [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Click on "Firestore Database" in the left sidebar
4. Click "Start collection" or "Create collection"
5. Create two collections:
   - **Collection ID**: `routes`
   - **Collection ID**: `pages`

#### **Step 2: Add Sample Routes**

Create a document in the `routes` collection with these fields:

| Field       | Type      | Value               | Description                |
| ----------- | --------- | ------------------- | -------------------------- |
| `oldPath`   | string    | `/about`            | Original route path        |
| `newPath`   | string    | `/services`         | New route to redirect to   |
| `active`    | boolean   | `true`              | Whether redirect is active |
| `createdAt` | timestamp | `serverTimestamp()` | Creation timestamp         |
| `updatedAt` | timestamp | `serverTimestamp()` | Last update timestamp      |

**Example Document:**

```json
{
  "oldPath": "/about",
  "newPath": "/services",
  "active": true,
  "createdAt": "serverTimestamp",
  "updatedAt": "serverTimestamp"
}
```

#### **Step 3: Add Sample Pages**

Create documents in the `pages` collection with these fields:

| Field       | Type      | Value               | Description               |
| ----------- | --------- | ------------------- | ------------------------- |
| `title`     | string    | `About Us`          | Page title for navigation |
| `path`      | string    | `/about`            | URL path                  |
| `component` | string    | `About`             | Component name to render  |
| `order`     | number    | `1`                 | Navigation order          |
| `visible`   | boolean   | `true`              | Show in navigation        |
| `active`    | boolean   | `true`              | Page is active            |
| `createdAt` | timestamp | `serverTimestamp()` | Creation timestamp        |
| `updatedAt` | timestamp | `serverTimestamp()` | Last update timestamp     |

**Example Documents:**

```json
{
  "title": "About Us",
  "path": "/about",
  "component": "About",
  "order": 1,
  "visible": true,
  "active": true,
  "createdAt": "serverTimestamp",
  "updatedAt": "serverTimestamp"
}
```

```json
{
  "title": "Contact",
  "path": "/contact",
  "component": "Contact",
  "order": 2,
  "visible": true,
  "active": true,
  "createdAt": "serverTimestamp",
  "updatedAt": "serverTimestamp"
}
```

```json
{
  "title": "Products",
  "path": "/products",
  "component": "Products",
  "order": 3,
  "visible": true,
  "active": true,
  "createdAt": "serverTimestamp",
  "updatedAt": "serverTimestamp"
}
```

```json
{
  "title": "Services",
  "path": "/services",
  "component": "Services",
  "order": 4,
  "visible": true,
  "active": true,
  "createdAt": "serverTimestamp",
  "updatedAt": "serverTimestamp"
}
```

#### **Step 4: Verify Setup**

After creating the collections and documents:

1. Your navigation should show: Home, About, Contact, Products, Services, Admin
2. You can test redirects by creating route rules in the Admin interface
3. You can edit pages through the Admin → Page Management tab

### 6. **Run the Application**

```bash
npm run dev
```

Visit `http://localhost:3000` to see the application.

### 6. **Troubleshooting Firestore Setup**

**Common Issues:**

- **"Missing or insufficient permissions"** → Check Firestore security rules
- **"Error connecting to Firebase"** → Verify your `.env` configuration
- **Navigation not showing pages** → Ensure pages have `visible: true` and `active: true`
- **Components not loading** → Check that component names match exactly (case-sensitive)

**Quick Verification:**

1. Check Firebase Console → Firestore Database → Data tab
2. Verify both `routes` and `pages` collections exist
3. Ensure documents have all required fields
4. Check that timestamps use `serverTimestamp()` function

## 🧪 Testing the System

### **Testing Page Management**

1. Go to Admin (Page Management tab is now the default)
2. Create a new page with title, path, and component
3. Set navigation order and visibility
4. See the page appear in navigation automatically
5. Use the "🔄 Reset to Defaults" button to restore original setup

### **Testing Dynamic Routing**

1. Go to Admin → Route Management tab
2. Add a route rule (e.g., oldPath: `/about`, newPath: `/services`)
3. Navigate to the old path in another tab
4. Activate the rule and watch the automatic redirect!

### **Testing Real-time Updates**

1. Open the app in multiple browser tabs
2. Make changes in the Admin interface
3. Watch changes appear immediately across all tabs

## 🎨 Key Features

### **Dynamic Routing**

- ✅ Real-time redirects based on Firestore data
- ✅ Works on page reload and client-side navigation
- ✅ Toggle routes on/off instantly
- ✅ No code changes required for redirects

### **Page Management**

- ✅ Create pages through CMS interface
- ✅ Edit pages with modal interface
- ✅ Control navigation visibility and order
- ✅ Dynamic component rendering
- ✅ Real-time navigation updates

### **Component Architecture**

- ✅ Reusable components (PageLayout, ComponentSelector, etc.)
- ✅ Organized component structure
- ✅ Easy to add new dynamic components
- ✅ Consistent styling and behavior

### **Admin Interface**

- ✅ Tabbed interface for different management tasks
- ✅ Modal editing for pages
- ✅ Form validation and error handling
- ✅ Real-time data synchronization
- ✅ Responsive design

## 🔧 Development

### **Adding New Dynamic Components**

1. Create your component in `src/components/DynamicComponents/`
2. Export it from `src/components/DynamicComponents/index.js`
3. Add it to `src/components/ComponentSelector.vue` options
4. Import it in `src/components/DynamicPage.vue`

### **Customizing the Layout**

- Modify `src/components/PageLayout.vue` for global layout changes
- Update `src/App.vue` for header/navigation changes
- Edit component styles in individual component files

### **Extending the CMS**

- Add new fields to page documents in Firestore
- Update `PageForm.vue` and `PageSettings.vue` for new fields
- Modify `DynamicPage.vue` to handle new data

### **Environment Variables**

- All Firebase configuration is stored in environment variables
- Copy `env.example` to `.env` and fill in your Firebase values
- The `.env` file is automatically ignored by Git for security
- Use `VITE_` prefix for variables that should be available in the browser

## 📚 Technologies Used

- **Vue.js 3** - Progressive JavaScript framework
- **Vue Router 4** - Client-side routing
- **Firebase Firestore** - Real-time database
- **Firebase Authentication** - User authentication
- **Vite** - Build tool and development server
- **CSS3** - Styling and responsive design

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🚀 Deployment

### **Quick Deploy to Firebase Hosting**

Deploy your application to get a live demo URL:

**Option 1: One-Command Deploy (Recommended)**

```bash
./deploy.sh
```

**Option 2: Manual Deploy**

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
npm run firebase:login

# Initialize Firebase Hosting
npm run firebase:init

# Deploy to Firebase
npm run deploy
```

**Your app will be live at**: `https://routing-cms.web.app` _(already deployed!)_

> **📖 Detailed Guide**: See `DEPLOYMENT.md` for complete deployment instructions, troubleshooting, and advanced configuration.

## 🔒 Security

### **Environment Variables**

- Firebase credentials are stored in environment variables
- The `.env` file is automatically ignored by Git
- Never commit your actual Firebase credentials to version control
- Use `env.example` as a template for required environment variables

### **Firebase Security Rules**

For production, implement proper Firestore security rules:

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

## 🆘 Support

For questions or issues:

1. Check the documentation in each component
2. Review the Firebase setup guide
3. Open an issue on GitHub

---

**Happy coding! 🚀**

# vue-routing-cms
