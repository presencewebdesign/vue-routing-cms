# Dynamic Components

This folder contains components that can be dynamically loaded by the CMS system. These components are rendered based on data stored in Firebase Firestore and can be managed through the Admin interface.

## 📁 Structure

```
DynamicComponents/
├── About.vue              # About page component
├── Contact.vue            # Contact page component
├── Products.vue           # Products page component
├── Services.vue           # Services page component
├── index.js               # Exports all components
└── README.md              # This documentation
```

## 🎯 How Dynamic Components Work

### **1. Component Registration**

Each component is:

- **Exported** from `index.js` for easy importing
- **Registered** in `ComponentSelector.vue` for CMS selection
- **Imported** in `DynamicPage.vue` for rendering

### **2. Dynamic Rendering Process**

1. **Page Creation**: Admin creates a page with a component name
2. **Data Storage**: Page data is stored in Firestore `pages` collection
3. **Component Selection**: `DynamicPage.vue` loads the page data
4. **Component Mapping**: Maps component name to actual Vue component
5. **Dynamic Rendering**: Uses Vue's `<component :is="">` to render the component

### **3. Component Structure**

All dynamic components follow this pattern:

```vue
<template>
  <PageLayout>
    <h1>{{ pageData?.title || "Page Title" }}</h1>
    <!-- Component-specific content -->
  </PageLayout>
</template>

<script>
import PageLayout from "../PageLayout.vue";

export default {
  name: "ComponentName",
  components: { PageLayout },
  props: {
    pageData: {
      type: Object,
      default: () => ({}),
    },
  },
};
</script>
```

## 📝 Available Components

### **About.vue**

- **Purpose**: About page with company information
- **Props**: Receives `pageData` from CMS
- **Features**: Responsive layout, consistent styling

### **Contact.vue**

- **Purpose**: Contact form and company contact information
- **Props**: Receives `pageData` from CMS
- **Features**: Form validation, responsive design

### **Products.vue**

- **Purpose**: Product showcase with cards
- **Props**: Receives `pageData` from CMS
- **Features**: Grid layout, hover effects, product cards

### **Services.vue**

- **Purpose**: Services listing with detailed information
- **Props**: Receives `pageData` from CMS
- **Features**: Service cards, feature lists, pricing

## 🔧 Adding New Dynamic Components

### **Step 1: Create the Component**

Create a new `.vue` file in this folder:

```vue
<template>
  <PageLayout>
    <h1>{{ pageData?.title || "My New Page" }}</h1>
    <p>Your component content here...</p>
  </PageLayout>
</template>

<script>
import PageLayout from "../PageLayout.vue";

export default {
  name: "MyNewComponent",
  components: { PageLayout },
  props: {
    pageData: {
      type: Object,
      default: () => ({}),
    },
  },
};
</script>

<style scoped>
/* Your component styles */
</style>
```

### **Step 2: Export from index.js**

Add your component to `index.js`:

```javascript
export { default as MyNewComponent } from "./MyNewComponent.vue";
```

### **Step 3: Add to Component Selector**

Update `src/components/ComponentSelector.vue`:

```vue
<option value="MyNewComponent">My New Component (Dynamic)</option>
```

### **Step 4: Import in DynamicPage**

Update `src/components/DynamicPage.vue`:

```javascript
import {
  About,
  Contact,
  Products,
  Services,
  MyNewComponent,
} from "./DynamicComponents";

const componentMap = ref({
  Home: Home,
  About: About,
  Contact: Contact,
  Products: Products,
  Services: Services,
  Admin: Admin,
  MyNewComponent: MyNewComponent, // Add this line
});
```

## 🎨 Component Guidelines

### **Required Structure**

- ✅ Use `PageLayout` wrapper for consistent styling
- ✅ Import PageLayout from `"../PageLayout.vue"`
- ✅ Register PageLayout in components
- ✅ Accept `pageData` prop for CMS data
- ✅ Use semantic HTML structure

### **Styling Guidelines**

- ✅ Use `scoped` styles to avoid conflicts
- ✅ Follow the existing color scheme (`#667eea` primary)
- ✅ Make components responsive
- ✅ Use consistent spacing and typography

### **Best Practices**

- ✅ Keep components focused on a single responsibility
- ✅ Use descriptive component names
- ✅ Add proper TypeScript-like prop validation
- ✅ Include helpful comments for complex logic
- ✅ Test components with different `pageData` values

## 🔄 Component Lifecycle

### **1. CMS Creation**

- Admin creates page in Admin interface
- Page data stored in Firestore
- Component name selected from dropdown

### **2. Navigation**

- User clicks navigation link
- Router navigates to page path
- `DynamicPage.vue` catches the route

### **3. Data Loading**

- `DynamicPage.vue` queries Firestore for page data
- Page data includes component name
- Component mapped from string to actual component

### **4. Rendering**

- Component rendered with `pageData` prop
- PageLayout provides consistent styling
- Component displays its specific content

## 🧪 Testing Components

### **Manual Testing**

1. Create a page in Admin interface
2. Assign your component to the page
3. Navigate to the page URL
4. Verify component renders correctly
5. Test with different `pageData` values

### **Development Testing**

```javascript
// Test component with mock data
const mockPageData = {
  title: "Test Page",
  path: "/test",
  component: "MyNewComponent",
  order: 1,
  visible: true,
  active: true,
};
```

## 📚 Related Files

- **`src/components/DynamicPage.vue`** - Renders dynamic components
- **`src/components/ComponentSelector.vue`** - CMS component selection
- **`src/components/PageLayout.vue`** - Consistent page layout
- **`src/components/Admin.vue`** - Page management interface

## 🚀 Tips for Development

1. **Start Simple**: Begin with basic content, add complexity later
2. **Test Responsively**: Ensure components work on mobile
3. **Follow Patterns**: Use existing components as templates
4. **Document Changes**: Update this README when adding components
5. **Consider Reusability**: Make components flexible for different use cases

---

**Remember**: All components in this folder are automatically available in the CMS and can be assigned to pages through the Admin interface!
