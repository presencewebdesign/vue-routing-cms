<template>
  <PageLayout>
    <h1>About Us</h1>
    <p>
      This is the About page that demonstrates how content can be dynamically
      managed through Firebase Firestore.
    </p>

    <div class="content">
      <h2>Our Mission</h2>
      <p>
        We're showcasing the power of CMS-controlled routing using Vue.js and
        Firebase. This approach allows content managers to control the user
        experience without requiring developer intervention.
      </p>

      <h2>Key Benefits</h2>
      <ul>
        <li>
          <strong>Real-time Updates:</strong> Changes are reflected immediately
          across all users
        </li>
        <li>
          <strong>No Code Deployment:</strong> Content managers can update
          routing without touching code
        </li>
        <li>
          <strong>Scalable:</strong> Works across multiple pages and complex
          routing scenarios
        </li>
        <li>
          <strong>Secure:</strong> Firebase provides robust security and
          authentication
        </li>
      </ul>

      <h2>Technology Stack</h2>
      <div class="tech-stack">
        <div class="tech-item">
          <h4>Vue.js 3</h4>
          <p>Modern reactive framework for building user interfaces</p>
        </div>
        <div class="tech-item">
          <h4>Vue Router</h4>
          <p>Official router for Vue.js applications</p>
        </div>
        <div class="tech-item">
          <h4>Firebase Firestore</h4>
          <p>NoSQL cloud database for real-time data synchronization</p>
        </div>
        <div class="tech-item">
          <h4>Vite</h4>
          <p>Fast build tool and development server</p>
        </div>
      </div>
    </div>
  </PageLayout>
</template>

<script>
import PageLayout from "../PageLayout.vue";

export default {
  name: "About",
  components: {
    PageLayout,
  },
};
</script>

<style scoped>
.content h2 {
  color: #667eea;
  margin: 1.5rem 0 0.5rem 0;
}

.content ul {
  margin: 1rem 0;
  padding-left: 1.5rem;
}

.content li {
  margin-bottom: 0.5rem;
}

.tech-stack {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
  margin-top: 1rem;
}

.tech-item {
  background: #f8f9fa;
  padding: 1rem;
  border-radius: 8px;
  border: 1px solid #e9ecef;
}

.tech-item h4 {
  color: #667eea;
  margin-bottom: 0.5rem;
}

.tech-item p {
  font-size: 0.9rem;
  color: #666;
}
</style>
