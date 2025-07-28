import { createApp } from "vue";
import { createRouter, createWebHistory } from "vue-router";
import App from "./App.vue";
import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
import { getAuth, signInAnonymously } from "firebase/auth";

// Firebase configuration from environment variables
const firebaseConfig = {
  apiKey: import.meta.env.VITE_FIREBASE_API_KEY,
  authDomain: import.meta.env.VITE_FIREBASE_AUTH_DOMAIN,
  projectId: import.meta.env.VITE_FIREBASE_PROJECT_ID,
  storageBucket: import.meta.env.VITE_FIREBASE_STORAGE_BUCKET,
  messagingSenderId: import.meta.env.VITE_FIREBASE_MESSAGING_SENDER_ID,
  appId: import.meta.env.VITE_FIREBASE_APP_ID,
};

// Initialize Firebase
const firebaseApp = initializeApp(firebaseConfig);
const db = getFirestore(firebaseApp);
const auth = getAuth(firebaseApp);

// Sign in anonymously for demo purposes
signInAnonymously(auth).catch((error) => {
  console.error("Error signing in anonymously:", error);
});

// Import components
import Home from "./components/Home.vue";
import Admin from "./components/Admin.vue";
import DynamicPage from "./components/DynamicPage.vue";
import NotFound from "./components/NotFound.vue";

// Create router
const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: "/", component: Home },
    { path: "/admin", component: Admin },
    { path: "/:pathMatch(.*)*", component: DynamicPage },
  ],
});

// Create and mount app
const app = createApp(App);
app.use(router);

// Provide Firebase instances globally
app.provide("db", db);
app.provide("auth", auth);

app.mount("#app");
