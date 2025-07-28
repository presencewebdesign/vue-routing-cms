<template>
  <PageLayout>
    <h1>Welcome to Routing CMS</h1>
    <p>
      This is a demonstration of how routing can be controlled through Firebase
      Firestore. The navigation and page content can be dynamically updated from
      the CMS.
    </p>

    <div class="features">
      <div class="feature">
        <h3>🎯 Dynamic Routing</h3>
        <p>
          Routes are controlled by Firebase Firestore. When you update the
          routing configuration in the database, users are automatically
          redirected to the new destination.
        </p>
      </div>

      <div class="feature">
        <h3>⚡ Real-time Updates</h3>
        <p>
          Changes made in the CMS are reflected immediately across all connected
          clients without requiring a page refresh.
        </p>
      </div>

      <div class="feature">
        <h3>🔧 Easy Management</h3>
        <p>
          Content managers can easily update routing rules, page content, and
          navigation structure through the Firebase console.
        </p>
      </div>
    </div>

    <div class="demo-info">
      <h3>How to Test:</h3>
      <ol>
        <li>
          Set up your Firebase project and update the configuration in
          <code>src/main.js</code>
        </li>
        <li>Create a collection called "routes" in Firestore</li>
        <li>
          Add documents with fields: <code>oldPath</code>, <code>newPath</code>,
          <code>active</code> (boolean)
        </li>
        <li>
          Navigate to a page and update the routing in Firestore to see
          real-time redirects
        </li>
      </ol>
    </div>
  </PageLayout>
</template>

<script>
import PageLayout from "./PageLayout.vue";

export default {
  name: "Home",
  components: {
    PageLayout,
  },
};
</script>

<style scoped>
.features {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin: 2rem 0;
}

.feature {
  background: #f8f9fa;
  padding: 1.5rem;
  border-radius: 8px;
  border-left: 4px solid #667eea;
}

.feature h3 {
  color: #667eea;
  margin-bottom: 0.5rem;
}

.demo-info {
  background: #e3f2fd;
  padding: 1.5rem;
  border-radius: 8px;
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
}

code {
  background: #f5f5f5;
  padding: 0.2rem 0.4rem;
  border-radius: 3px;
  font-family: "Courier New", monospace;
}
</style>
