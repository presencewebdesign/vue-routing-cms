<template>
  <PageLayout>
    <h1>Admin Dashboard</h1>
    <p>
      Manage routing rules and pages through the CMS. Changes here will be
      reflected immediately across all connected clients.
    </p>

    <!-- Tab Navigation -->
    <div class="tab-navigation">
      <button
        @click="activeTab = 'routes'"
        :class="['tab-button', { active: activeTab === 'routes' }]"
      >
        Route Management
      </button>
      <button
        @click="activeTab = 'pages'"
        :class="['tab-button', { active: activeTab === 'pages' }]"
      >
        Page Management
      </button>
    </div>

    <!-- Routes Tab -->
    <div v-if="activeTab === 'routes'" class="tab-content">
      <div class="admin-content">
        <div class="route-form">
          <h2>Add New Route Rule</h2>
          <form @submit.prevent="addRoute">
            <div class="form-group">
              <label for="oldPath">Old Path</label>
              <input
                type="text"
                id="oldPath"
                v-model="newRoute.oldPath"
                placeholder="/about"
                required
              />
            </div>

            <div class="form-group">
              <label for="newPath">New Path</label>
              <input
                type="text"
                id="newPath"
                v-model="newRoute.newPath"
                placeholder="/services"
                required
              />
            </div>

            <div class="form-group">
              <label>
                <input type="checkbox" v-model="newRoute.active" />
                Active
              </label>
            </div>

            <button type="submit" class="btn" :disabled="submitting">
              {{ submitting ? "Adding..." : "Add Route Rule" }}
            </button>
          </form>
        </div>

        <div class="routes-list">
          <h2>Current Route Rules</h2>
          <div v-if="loading" class="loading">
            <div class="spinner"></div>
            <p>Loading routes...</p>
          </div>

          <div v-else-if="routes.length === 0" class="no-routes">
            <p>No route rules found. Add your first rule above.</p>
          </div>

          <div v-else class="route-items">
            <div v-for="route in routes" :key="route.id" class="route-item">
              <div class="route-info">
                <div class="route-paths">
                  <span class="old-path">{{ route.oldPath }}</span>
                  <span class="arrow">→</span>
                  <span class="new-path">{{ route.newPath }}</span>
                </div>
                <div class="route-status">
                  <span
                    :class="['status', route.active ? 'active' : 'inactive']"
                  >
                    {{ route.active ? "Active" : "Inactive" }}
                  </span>
                </div>
              </div>
              <div class="route-actions">
                <button @click="toggleRoute(route)" class="btn btn-small">
                  {{ route.active ? "Deactivate" : "Activate" }}
                </button>
                <button
                  @click="deleteRoute(route.id)"
                  class="btn btn-small btn-danger"
                >
                  Delete
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="demo-info">
        <h3>💡 How to Test Routes</h3>
        <ol>
          <li>
            Add a route rule above (e.g., oldPath: "/about", newPath:
            "/services")
          </li>
          <li>Navigate to the old path in another tab</li>
          <li>Activate the rule and watch the automatic redirect!</li>
          <li>Try deactivating the rule to see the redirect stop working</li>
        </ol>
      </div>
    </div>

    <!-- Pages Tab -->
    <div v-if="activeTab === 'pages'" class="tab-content">
      <div class="page-manager-content">
        <div class="page-form">
          <h2>Add New Page</h2>
          <PageForm
            v-model="newPage"
            :submitting="pagesSubmitting"
            submit-text="Add Page"
            @submit="addPage"
          />
        </div>

        <div class="pages-list">
          <h2>Current Pages</h2>
          <div v-if="pagesLoading" class="loading">
            <div class="spinner"></div>
            <p>Loading pages...</p>
          </div>

          <div v-else-if="pages.length === 0" class="no-pages">
            <p>No pages found. Add your first page above.</p>
          </div>

          <div v-else class="page-items">
            <div v-for="page in sortedPages" :key="page.id" class="page-item">
              <div class="page-info">
                <div class="page-header">
                  <h3>{{ page.title }}</h3>
                  <div class="page-status">
                    <span
                      :class="['status', page.active ? 'active' : 'inactive']"
                    >
                      {{ page.active ? "Active" : "Inactive" }}
                    </span>
                    <span
                      :class="['status', page.visible ? 'visible' : 'hidden']"
                    >
                      {{ page.visible ? "Visible" : "Hidden" }}
                    </span>
                  </div>
                </div>
                <div class="page-details">
                  <p><strong>Path:</strong> {{ page.path }}</p>
                  <p><strong>Component:</strong> {{ page.component }}</p>
                  <p><strong>Order:</strong> {{ page.order }}</p>
                </div>
              </div>
              <div class="page-actions">
                <button
                  @click="editPage(page)"
                  class="btn btn-small btn-primary"
                >
                  Edit
                </button>
                <button @click="togglePageActive(page)" class="btn btn-small">
                  {{ page.active ? "Deactivate" : "Activate" }}
                </button>
                <button @click="togglePageVisible(page)" class="btn btn-small">
                  {{ page.visible ? "Hide" : "Show" }}
                </button>
                <button
                  @click="deletePage(page.id)"
                  class="btn btn-small btn-danger"
                >
                  Delete
                </button>
              </div>
            </div>
          </div>
        </div>
        <!-- Edit Page Modal -->
        <div v-if="editingPage" class="modal-overlay" @click="cancelEdit">
          <div class="modal-content" @click.stop>
            <div class="modal-header">
              <h2>Edit Page</h2>
              <button @click="cancelEdit" class="modal-close">&times;</button>
            </div>
            <PageForm
              v-model="editingPage"
              :submitting="updatingPage"
              submit-text="Update Page"
              :show-cancel="true"
              @submit="updatePage"
              @cancel="cancelEdit"
            />
          </div>
        </div>
      </div>

      <div class="demo-info">
        <h3>💡 How Page Management Works</h3>
        <ol>
          <li>Add pages with their title, path, and component</li>
          <li>Set navigation order to control menu position</li>
          <li>Toggle visibility to show/hide from navigation</li>
          <li>Toggle active status to enable/disable the page</li>
          <li>Navigation will update automatically across all clients</li>
        </ol>
      </div>
    </div>
  </PageLayout>
</template>

<script>
import { ref, reactive, onMounted, inject, computed } from "vue";
import {
  collection,
  addDoc,
  updateDoc,
  deleteDoc,
  doc,
  onSnapshot,
  query,
  orderBy,
  serverTimestamp,
} from "firebase/firestore";
import ComponentSelector from "./ComponentSelector.vue";
import PageSettings from "./PageSettings.vue";
import PageForm from "./PageForm.vue";
import PageLayout from "./PageLayout.vue";

export default {
  name: "Admin",
  components: {
    ComponentSelector,
    PageSettings,
    PageForm,
    PageLayout,
  },
  setup() {
    const db = inject("db");
    const activeTab = ref("routes");

    // Route management
    const routes = ref([]);
    const loading = ref(true);
    const submitting = ref(false);
    const newRoute = reactive({
      oldPath: "",
      newPath: "",
      active: true,
    });

    // Page management
    const pages = ref([]);
    const pagesLoading = ref(true);
    const pagesSubmitting = ref(false);
    const newPage = reactive({
      title: "",
      path: "",
      component: "",
      order: 1,
      visible: true,
      active: true,
    });

    const sortedPages = computed(() => {
      return pages.value.sort((a, b) => a.order - b.order);
    });

    const editingPage = ref(null);
    const updatingPage = ref(false);

    onMounted(() => {
      if (db) {
        // Load routes
        const routesRef = collection(db, "routes");
        const routesQuery = query(routesRef, orderBy("createdAt", "desc"));
        onSnapshot(
          routesQuery,
          (snapshot) => {
            routes.value = snapshot.docs.map((doc) => ({
              id: doc.id,
              ...doc.data(),
            }));
            loading.value = false;
          },
          (error) => {
            console.error("Error listening to routes:", error);
            alert(`Error connecting to Firebase: ${error.message}`);
          }
        );

        // Load pages
        const pagesRef = collection(db, "pages");
        const pagesQuery = query(pagesRef, orderBy("order"));
        onSnapshot(
          pagesQuery,
          (snapshot) => {
            pages.value = snapshot.docs.map((doc) => ({
              id: doc.id,
              ...doc.data(),
            }));
            pagesLoading.value = false;
          },
          (error) => {
            console.error("Error listening to pages:", error);
            alert(`Error connecting to Firebase: ${error.message}`);
          }
        );
      } else {
        alert("Firebase database not available");
      }
    });

    const addRoute = async () => {
      if (!db) return;

      // Validate form data
      if (!newRoute.oldPath.trim() || !newRoute.newPath.trim()) {
        alert("Please fill in both Old Path and New Path fields.");
        return;
      }

      // Ensure paths start with /
      const oldPath = newRoute.oldPath.startsWith("/")
        ? newRoute.oldPath
        : "/" + newRoute.oldPath;
      const newPath = newRoute.newPath.startsWith("/")
        ? newRoute.newPath
        : "/" + newRoute.newPath;

      submitting.value = true;
      try {
        const routeData = {
          oldPath: oldPath,
          newPath: newPath,
          active: newRoute.active,
          createdAt: serverTimestamp(),
          updatedAt: serverTimestamp(),
        };

        console.log("Adding route:", routeData); // Debug log

        await addDoc(collection(db, "routes"), routeData);

        // Reset form
        newRoute.oldPath = "";
        newRoute.newPath = "";
        newRoute.active = true;

        alert("Route rule added successfully!");
      } catch (error) {
        console.error("Error adding route:", error);
        alert(
          `Error adding route rule: ${error.message}. Please check Firebase permissions.`
        );
      } finally {
        submitting.value = false;
      }
    };

    const toggleRoute = async (route) => {
      if (!db) return;

      try {
        const routeRef = doc(db, "routes", route.id);
        await updateDoc(routeRef, {
          active: !route.active,
          updatedAt: serverTimestamp(),
        });
      } catch (error) {
        console.error("Error updating route:", error);
        alert("Error updating route. Please try again.");
      }
    };

    const deleteRoute = async (routeId) => {
      if (!db) return;

      if (!confirm("Are you sure you want to delete this route rule?")) return;

      try {
        await deleteDoc(doc(db, "routes", routeId));
        alert("Route rule deleted successfully!");
      } catch (error) {
        console.error("Error deleting route:", error);
        alert("Error deleting route. Please try again.");
      }
    };

    // Page management functions
    const addPage = async () => {
      if (!db) return;

      // Validate form data
      if (
        !newPage.title.trim() ||
        !newPage.path.trim() ||
        !newPage.component.trim()
      ) {
        alert("Please fill in all required fields.");
        return;
      }

      // Ensure path starts with /
      const path = newPage.path.startsWith("/")
        ? newPage.path
        : "/" + newPage.path;

      pagesSubmitting.value = true;
      try {
        const pageData = {
          title: newPage.title,
          path: path,
          component: newPage.component,
          order: parseInt(newPage.order),
          visible: newPage.visible,
          active: newPage.active,
          createdAt: serverTimestamp(),
          updatedAt: serverTimestamp(),
        };

        console.log("Adding page:", pageData); // Debug log

        await addDoc(collection(db, "pages"), pageData);

        // Reset form
        newPage.title = "";
        newPage.path = "";
        newPage.component = "";
        newPage.order = 1;
        newPage.visible = true;
        newPage.active = true;

        alert("Page added successfully!");
      } catch (error) {
        console.error("Error adding page:", error);
        alert(
          `Error adding page: ${error.message}. Please check Firebase permissions.`
        );
      } finally {
        pagesSubmitting.value = false;
      }
    };

    const togglePageActive = async (page) => {
      if (!db) return;

      try {
        const pageRef = doc(db, "pages", page.id);
        await updateDoc(pageRef, {
          active: !page.active,
          updatedAt: serverTimestamp(),
        });
      } catch (error) {
        console.error("Error updating page active:", error);
        alert("Error updating page. Please try again.");
      }
    };

    const togglePageVisible = async (page) => {
      if (!db) return;

      try {
        const pageRef = doc(db, "pages", page.id);
        await updateDoc(pageRef, {
          visible: !page.visible,
          updatedAt: serverTimestamp(),
        });
      } catch (error) {
        console.error("Error updating page visible:", error);
        alert("Error updating page. Please try again.");
      }
    };

    const deletePage = async (pageId) => {
      if (!db) return;

      if (!confirm("Are you sure you want to delete this page?")) return;

      try {
        await deleteDoc(doc(db, "pages", pageId));
        alert("Page deleted successfully!");
      } catch (error) {
        console.error("Error deleting page:", error);
        alert("Error deleting page. Please try again.");
      }
    };

    const editPage = (page) => {
      editingPage.value = { ...page };
    };

    const updatePage = async () => {
      if (!db || !editingPage.value) return;
      updatingPage.value = true;
      const pageId = editingPage.value.id;
      const path = editingPage.value.path.startsWith("/")
        ? editingPage.value.path
        : "/" + editingPage.value.path;
      try {
        await updateDoc(doc(db, "pages", pageId), {
          title: editingPage.value.title,
          path,
          component: editingPage.value.component,
          order: parseInt(editingPage.value.order),
          visible: editingPage.value.visible,
          active: editingPage.value.active,
          updatedAt: serverTimestamp(),
        });
        editingPage.value = null;
        alert("Page updated successfully!");
      } catch (error) {
        console.error("Error updating page:", error);
        alert(`Error updating page: ${error.message}`);
      } finally {
        updatingPage.value = false;
      }
    };

    const cancelEdit = () => {
      editingPage.value = null;
    };

    return {
      activeTab,
      routes,
      loading,
      submitting,
      newRoute,
      addRoute,
      toggleRoute,
      deleteRoute,
      pages,
      pagesLoading,
      pagesSubmitting,
      newPage,
      sortedPages,
      addPage,
      togglePageActive,
      togglePageVisible,
      deletePage,
      editingPage,
      updatingPage,
      editPage,
      updatePage,
      cancelEdit,
    };
  },
};
</script>

<style scoped>
/* Tab Navigation */
.tab-navigation {
  display: flex;
  gap: 0.5rem;
  margin: 2rem 0;
  border-bottom: 2px solid #e9ecef;
}

.tab-button {
  padding: 0.75rem 1.5rem;
  background: none;
  border: none;
  border-bottom: 3px solid transparent;
  cursor: pointer;
  font-size: 1rem;
  font-weight: 500;
  color: #666;
  transition: all 0.3s ease;
}

.tab-button:hover {
  color: #667eea;
}

.tab-button.active {
  color: #667eea;
  border-bottom-color: #667eea;
}

.tab-content {
  margin-top: 2rem;
}

.admin-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
  margin: 2rem 0;
}

.page-manager-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
  margin: 2rem 0;
}

.route-form h2,
.routes-list h2,
.page-form h2,
.pages-list h2 {
  color: #667eea;
  margin-bottom: 1.5rem;
}

.form-group {
  margin-bottom: 1.5rem;
}

.form-group label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: 500;
  color: #333;
}

.form-group input[type="text"] {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid #ddd;
  border-radius: 5px;
  font-size: 1rem;
}

.form-group input[type="checkbox"] {
  margin-right: 0.5rem;
}

.route-items {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.route-item {
  background: #f8f9fa;
  border: 1px solid #e9ecef;
  border-radius: 8px;
  padding: 1rem;
}

.route-info {
  margin-bottom: 1rem;
}

.route-paths {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 0.5rem;
}

.old-path {
  color: #dc3545;
  font-weight: 500;
}

.arrow {
  color: #667eea;
  font-weight: bold;
}

.new-path {
  color: #28a745;
  font-weight: 500;
}

.route-status {
  margin-bottom: 1rem;
}

.status {
  padding: 0.25rem 0.5rem;
  border-radius: 3px;
  font-size: 0.8rem;
  font-weight: 500;
}

.status.active {
  background: #d4edda;
  color: #155724;
}

.status.inactive {
  background: #f8d7da;
  color: #721c24;
}

.route-actions {
  display: flex;
  gap: 0.5rem;
}

.btn-small {
  padding: 0.5rem 1rem;
  font-size: 0.9rem;
}

.btn-danger {
  background: #dc3545;
}

.btn-danger:hover {
  background: #c82333;
}

.loading,
.no-routes {
  text-align: center;
  padding: 2rem;
  color: #666;
}

.spinner {
  width: 30px;
  height: 30px;
  border: 3px solid #f3f3f3;
  border-top: 3px solid #667eea;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin: 0 auto 1rem auto;
}

@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

.demo-info {
  background: #e3f2fd;
  border: 1px solid #bbdefb;
  border-radius: 8px;
  padding: 1.5rem;
  margin-top: 2rem;
}

.demo-info h3 {
  color: #1976d2;
  margin-bottom: 1rem;
}

.demo-info ol {
  padding-left: 1.5rem;
}

.demo-info li {
  margin-bottom: 0.5rem;
  color: #1976d2;
}

/* Page Management Styles */
.page-item {
  background: #f8f9fa;
  border: 1px solid #e9ecef;
  border-radius: 8px;
  padding: 1rem;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 1rem;
}

.page-header h3 {
  margin: 0;
  color: #333;
}

.page-status {
  display: flex;
  gap: 0.5rem;
}

.status.visible {
  background: #d4edda;
  color: #155724;
}

.status.hidden {
  background: #f8d7da;
  color: #721c24;
}

.page-details {
  margin-bottom: 1rem;
}

.page-details p {
  margin: 0.25rem 0;
  font-size: 0.9rem;
  color: #666;
}

.page-actions {
  display: flex;
  gap: 0.5rem;
}

.no-pages {
  text-align: center;
  padding: 2rem;
  color: #666;
}

/* Modal Styles */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  border-radius: 8px;
  padding: 0;
  max-width: 500px;
  width: 90%;
  max-height: 90vh;
  overflow-y: auto;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem 1.5rem 0 1.5rem;
  border-bottom: 1px solid #e9ecef;
  margin-bottom: 1.5rem;
}

.modal-header h2 {
  margin: 0;
  color: #667eea;
}

.modal-close {
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
  color: #666;
  padding: 0;
  width: 30px;
  height: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  transition: background-color 0.3s ease;
}

.modal-close:hover {
  background: #f8f9fa;
  color: #333;
}

.modal-content form {
  padding: 0 1.5rem 1.5rem 1.5rem;
}

.btn-secondary {
  background: #6c757d;
}

.btn-secondary:hover {
  background: #5a6268;
}

@media (max-width: 768px) {
  .admin-content,
  .page-manager-content {
    grid-template-columns: 1fr;
    gap: 2rem;
  }

  .tab-navigation {
    flex-direction: column;
    gap: 0;
  }

  .tab-button {
    border-bottom: none;
    border-left: 3px solid transparent;
    text-align: left;
  }

  .tab-button.active {
    border-left-color: #667eea;
  }
}
</style>
