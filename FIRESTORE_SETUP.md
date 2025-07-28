# Firestore Setup Quick Reference

## 🚀 Quick Setup Checklist

### **1. Firebase Project Setup**

- [ ] Create Firebase project at [console.firebase.google.com](https://console.firebase.google.com/)
- [ ] Enable Firestore Database
- [ ] Set security rules to `allow read, write: if true` (for demo)
- [ ] Enable Anonymous Authentication (optional)

### **2. Environment Configuration**

- [ ] Copy `env.example` to `.env`
- [ ] Fill in your Firebase config values
- [ ] Verify `.env` is in `.gitignore`

### **3. Firestore Collections**

#### **Routes Collection**

Collection ID: `routes`

| Field       | Type      | Example Value       |
| ----------- | --------- | ------------------- |
| `oldPath`   | string    | `/about`            |
| `newPath`   | string    | `/services`         |
| `active`    | boolean   | `true`              |
| `createdAt` | timestamp | `serverTimestamp()` |
| `updatedAt` | timestamp | `serverTimestamp()` |

#### **Pages Collection**

Collection ID: `pages`

| Field       | Type      | Example Value       |
| ----------- | --------- | ------------------- |
| `title`     | string    | `About Us`          |
| `path`      | string    | `/about`            |
| `component` | string    | `About`             |
| `order`     | number    | `1`                 |
| `visible`   | boolean   | `true`              |
| `active`    | boolean   | `true`              |
| `createdAt` | timestamp | `serverTimestamp()` |
| `updatedAt` | timestamp | `serverTimestamp()` |

### **4. Sample Data**

#### **Sample Routes Document**

```json
{
  "oldPath": "/about",
  "newPath": "/services",
  "active": true,
  "createdAt": "serverTimestamp",
  "updatedAt": "serverTimestamp"
}
```

#### **Sample Pages Documents**

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

### **5. Verification Steps**

After setup, verify:

- [ ] Navigation shows: Home, About, Contact, Products, Services, Admin
- [ ] Pages load correctly when clicked
- [ ] Admin interface works (Route Management & Page Management tabs)
- [ ] Real-time updates work (test in multiple browser tabs)

### **6. Common Issues & Solutions**

| Issue                                 | Solution                                  |
| ------------------------------------- | ----------------------------------------- |
| "Missing or insufficient permissions" | Check Firestore security rules            |
| "Error connecting to Firebase"        | Verify `.env` configuration               |
| Navigation not showing pages          | Ensure `visible: true` and `active: true` |
| Components not loading                | Check component names match exactly       |
| Timestamps not working                | Use `serverTimestamp()` function          |

### **7. Security Rules (Production)**

For production, use these security rules:

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

**Need help?** Check the main README.md for detailed instructions!
