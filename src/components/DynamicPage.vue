<template>
  <PageLayout>
    <div v-if="loading" class="loading">
      <div class="spinner"></div>
      <p>Loading page...</p>
      <p style="font-size: 12px; color: #666">Path: {{ currentPath }}</p>
    </div>

    <div v-else-if="!pageData" class="not-found">
      <h1>Page Not Found</h1>
      <p>This page doesn't exist or has been removed from the CMS.</p>
      <p><strong>Path:</strong> {{ currentPath }}</p>
      <router-link to="/" class="btn">Go Home</router-link>
    </div>

    <div v-else>
      <!-- Debug info -->
      <div
        v-if="pageData"
        class="debug-info"
        style="
          background: #f0f0f0;
          padding: 10px;
          margin-bottom: 20px;
          font-size: 12px;
        "
      >
        <strong>Debug Info:</strong><br />
        Component: {{ pageData.component }}<br />
        Selected Component: {{ selectedComponent ? "Found" : "Not Found"
        }}<br />
        Available Components:
        {{ Object.keys(componentMap.value || {}).join(", ") }}<br />
        Component Type: {{ typeof selectedComponent }}
      </div>

      <!-- Render the actual component -->
      <div v-if="selectedComponent">
        <p style="color: green; font-weight: bold">
          ✅ Component found and rendering...
        </p>
        <component :is="selectedComponent" :page-data="pageData" />
      </div>

      <div v-else-if="pageData">
        <p style="color: red; font-weight: bold">
          ❌ Component not found for: {{ pageData.component }}
        </p>
      </div>

      <!-- Fallback if component doesn't exist -->
      <div v-else class="fallback-content">
        <h1>{{ pageData.title }}</h1>
        <p>This is a dynamically loaded page from the CMS.</p>

        <div class="page-info">
          <h3>Page Information</h3>
          <ul>
            <li><strong>Path:</strong> {{ pageData.path }}</li>
            <li><strong>Component:</strong> {{ pageData.component }}</li>
            <li><strong>Order:</strong> {{ pageData.order }}</li>
            <li>
              <strong>Visible:</strong> {{ pageData.visible ? "Yes" : "No" }}
            </li>
            <li>
              <strong>Active:</strong> {{ pageData.active ? "Yes" : "No" }}
            </li>
          </ul>
        </div>

        <div class="demo-note">
          <h3>💡 Demo Note</h3>
          <p>
            This page was created through the CMS. The component "{{
              pageData.component
            }}" is not available.
          </p>
          <p>
            Available components: Home, About, Contact, Products, Services,
            Admin
          </p>
        </div>
      </div>
    </div>
  </PageLayout>
</template>

<script>
import { ref, onMounted, inject, computed, watch } from "vue";
import { useRoute } from "vue-router";
import { collection, query, where, getDocs } from "firebase/firestore";

// Import all available components
import Home from "./Home.vue";
import { About, Contact, Products, Services } from "./DynamicComponents";
import Admin from "./Admin.vue";
import PageLayout from "./PageLayout.vue";

export default {
  name: "DynamicPage",
  components: {
    Home,
    About,
    Contact,
    Products,
    Services,
    Admin,
    PageLayout,
  },
  setup() {
    const route = useRoute();
    const db = inject("db");
    const loading = ref(true);
    const pageData = ref(null);

    const currentPath = computed(() => route.path);

    // Map component names to actual components
    const componentMap = ref({
      Home: Home,
      About: About,
      Contact: Contact,
      Products: Products,
      Services: Services,
      Admin: Admin,
    });

    console.log("Component map initialized:", Object.keys(componentMap.value));
    console.log(
      "Component map values:",
      Object.values(componentMap.value).map((c) => c?.name || "undefined")
    );

    // Get the selected component based on page data
    const selectedComponent = computed(() => {
      if (!pageData.value) {
        console.log("No page data available");
        return null;
      }

      const componentName = pageData.value.component;
      const component = componentMap.value[componentName];

      console.log("Page component:", componentName);
      console.log("Available components:", Object.keys(componentMap.value));
      console.log("Selected component:", component);

      return component || null;
    });

    onMounted(async () => {
      console.log("DynamicPage mounted for path:", currentPath.value);

      // Set a timeout to prevent infinite loading
      const timeout = setTimeout(() => {
        console.log("Loading timeout reached");
        loading.value = false;
      }, 3000); // 3 second timeout

      if (db) {
        try {
          console.log("Checking for page at path:", currentPath.value);

          const pagesRef = collection(db, "pages");
          console.log("Pages collection reference created");

          // First, let's get all pages to see what's available
          const allPagesQuery = query(pagesRef);
          const allPagesSnapshot = await getDocs(allPagesQuery);
          console.log(
            "All pages in database:",
            allPagesSnapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }))
          );

          const pagesQuery = query(
            pagesRef,
            where("path", "==", currentPath.value),
            where("active", "==", true)
          );

          console.log("Executing Firebase query for path:", currentPath.value);
          const snapshot = await getDocs(pagesQuery);
          console.log("Found pages for this path:", snapshot.docs.length);

          if (!snapshot.empty) {
            const doc = snapshot.docs[0];
            pageData.value = {
              id: doc.id,
              ...doc.data(),
            };
            console.log("Page data loaded:", pageData.value);
          } else {
            console.log("No page found for path:", currentPath.value);
            // Let's check if there are any pages with this path but inactive
            const inactiveQuery = query(
              pagesRef,
              where("path", "==", currentPath.value)
            );
            const inactiveSnapshot = await getDocs(inactiveQuery);
            console.log(
              "Inactive pages with this path:",
              inactiveSnapshot.docs.length
            );
          }
        } catch (error) {
          console.error("Error loading page:", error);
          console.error("Error details:", error.message);
        } finally {
          clearTimeout(timeout);
          loading.value = false;
          console.log("Loading completed");
        }
      } else {
        console.log("Firebase not available");
        clearTimeout(timeout);
        loading.value = false;
      }
    });

    // Also watch for route changes to reload page data
    watch(currentPath, async (newPath) => {
      console.log("Route changed to:", newPath);
      loading.value = true;
      pageData.value = null;

      if (db) {
        try {
          console.log("Checking for page at path:", newPath);

          const pagesRef = collection(db, "pages");
          const pagesQuery = query(
            pagesRef,
            where("path", "==", newPath),
            where("active", "==", true)
          );

          console.log("Executing Firebase query for path:", newPath);
          const snapshot = await getDocs(pagesQuery);
          console.log("Found pages for this path:", snapshot.docs.length);

          if (!snapshot.empty) {
            const doc = snapshot.docs[0];
            pageData.value = {
              id: doc.id,
              ...doc.data(),
            };
            console.log("Page data loaded:", pageData.value);
          } else {
            console.log("No page found for path:", newPath);
          }
        } catch (error) {
          console.error("Error loading page:", error);
          console.error("Error details:", error.message);
        } finally {
          loading.value = false;
          console.log("Loading completed");
        }
      } else {
        loading.value = false;
      }
    });

    return {
      loading,
      pageData,
      selectedComponent,
      currentPath,
      componentMap,
    };
  },
};
</script>

<style scoped>
.loading {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 400px;
}

.spinner {
  width: 40px;
  height: 40px;
  border: 4px solid #f3f3f3;
  border-top: 4px solid #667eea;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 1rem;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

.not-found {
  text-align: center;
  padding: 3rem 0;
}

.not-found h1 {
  color: #667eea;
  margin-bottom: 1rem;
}

.fallback-content {
  padding: 2rem 0;
}

.page-info {
  background: #f8f9fa;
  padding: 1.5rem;
  border-radius: 8px;
  margin: 2rem 0;
}

.page-info h3 {
  color: #667eea;
  margin-bottom: 1rem;
}

.page-info ul {
  list-style: none;
  padding: 0;
}

.page-info li {
  padding: 0.5rem 0;
  border-bottom: 1px solid #e9ecef;
}

.page-info li:last-child {
  border-bottom: none;
}

.demo-note {
  background: #e3f2fd;
  border: 1px solid #bbdefb;
  border-radius: 8px;
  padding: 1.5rem;
  margin-top: 2rem;
}

.demo-note h3 {
  color: #1976d2;
  margin-bottom: 1rem;
}

.demo-note p {
  margin-bottom: 1rem;
  color: #1976d2;
}
</style>
