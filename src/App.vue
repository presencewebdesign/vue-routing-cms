<template>
  <div id="app">
    <header class="header">
      <div class="container">
        <h1 class="logo">Routing CMS</h1>
        <nav class="nav">
          <router-link to="/" class="nav-link">Home</router-link>

          <!-- Dynamic navigation from CMS -->
          <router-link
            v-for="page in visiblePages"
            :key="page.id"
            :to="page.path"
            class="nav-link"
          >
            {{ page.title }}
          </router-link>

          <router-link to="/admin" class="nav-link">Admin</router-link>
        </nav>
      </div>
    </header>

    <main class="main">
      <div class="container">
        <div v-if="loading" class="loading">
          <div class="spinner"></div>
          <p>Loading route configuration...</p>
        </div>

        <router-view v-else />
      </div>
    </main>

    <footer class="footer">
      <div class="container">
        <p>
          &copy; 2024 Routing CMS Demo. Routes controlled by Firebase Firestore.
        </p>
      </div>
    </footer>
  </div>
</template>

<script>
import { ref, onMounted, inject, watch, computed } from "vue";
import { useRouter } from "vue-router";
import {
  collection,
  onSnapshot,
  query,
  where,
  getDocs,
  orderBy,
} from "firebase/firestore";

export default {
  name: "App",
  setup() {
    const router = useRouter();
    const db = inject("db");
    const loading = ref(true);
    const activeRoutes = ref([]);
    const pages = ref([]);

    // Computed property for visible navigation pages
    const visiblePages = computed(() => {
      return pages.value
        .filter((page) => page.visible && page.active)
        .sort((a, b) => a.order - b.order);
    });

    // Function to check if current path should be redirected
    const checkForRedirect = async (currentPath) => {
      if (!db) return;

      try {
        const routesRef = collection(db, "routes");
        const routesQuery = query(routesRef, where("active", "==", true));
        const snapshot = await getDocs(routesQuery);

        snapshot.forEach((doc) => {
          const routeData = doc.data();
          if (routeData.oldPath === currentPath && routeData.newPath) {
            router.push(routeData.newPath);
          }
        });
      } catch (error) {
        console.error("Error checking for redirects:", error);
      }
    };

    onMounted(async () => {
      if (db) {
        // Listen for route changes in Firestore
        const routesRef = collection(db, "routes");
        const routesQuery = query(routesRef, where("active", "==", true));

        onSnapshot(routesQuery, (snapshot) => {
          activeRoutes.value = snapshot.docs.map((doc) => ({
            id: doc.id,
            ...doc.data(),
          }));

          // Check for redirects when routes change
          const currentPath = router.currentRoute.value.path;
          checkForRedirect(currentPath);
        });

        // Listen for page changes in Firestore
        const pagesRef = collection(db, "pages");
        const pagesQuery = query(pagesRef, orderBy("order"));

        onSnapshot(pagesQuery, (snapshot) => {
          pages.value = snapshot.docs.map((doc) => ({
            id: doc.id,
            ...doc.data(),
          }));
        });

        loading.value = false;
      }
    });

    // Watch for route changes and check for redirects
    watch(
      () => router.currentRoute.value.path,
      (newPath) => {
        checkForRedirect(newPath);
      }
    );

    return {
      loading,
      visiblePages,
    };
  },
};
</script>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  line-height: 1.6;
  color: #333;
  background-color: #f8f9fa;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

.header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 1rem 0;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.header .container {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo {
  font-size: 1.5rem;
  font-weight: bold;
}

.nav {
  display: flex;
  gap: 2rem;
}

.nav-link {
  color: white;
  text-decoration: none;
  padding: 0.5rem 1rem;
  border-radius: 5px;
  transition: background-color 0.3s ease;
}

.nav-link:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.nav-link.router-link-active {
  background-color: rgba(255, 255, 255, 0.2);
}

.main {
  min-height: calc(100vh - 140px);
  padding: 2rem 0;
}

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

.footer {
  background-color: #333;
  color: white;
  text-align: center;
  padding: 1rem 0;
}

.btn {
  display: inline-block;
  padding: 0.75rem 1.5rem;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  text-decoration: none;
  border-radius: 5px;
  transition: transform 0.3s ease;
}

.btn:hover {
  transform: translateY(-2px);
}
</style>
