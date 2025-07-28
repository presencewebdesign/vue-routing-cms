<template>
  <div class="page not-found">
    <div class="error-content">
      <div class="error-code">404</div>
      <h1>Page Not Found</h1>
      <p>
        The page you're looking for doesn't exist or has been moved. This could
        be due to a routing change in the CMS.
      </p>

      <div class="actions">
        <router-link to="/" class="btn">Go Home</router-link>
        <button @click="goBack" class="btn btn-secondary">Go Back</button>
      </div>

      <div class="demo-info">
        <h3>💡 Demo Information</h3>
        <p>
          This 404 page is shown when a route doesn't exist. In a real
          application, you could:
        </p>
        <ul>
          <li>Check the CMS for alternative routes</li>
          <li>Show suggested pages based on the URL</li>
          <li>Log the 404 for analysis</li>
          <li>Redirect to a custom error page</li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import { useRouter } from "vue-router";

export default {
  name: "NotFound",
  setup() {
    const router = useRouter();

    const goBack = () => {
      router.go(-1);
    };

    return {
      goBack,
    };
  },
};
</script>

<style scoped>
.not-found {
  text-align: center;
  padding: 3rem 0;
}

.error-content {
  max-width: 600px;
  margin: 0 auto;
}

.error-code {
  font-size: 8rem;
  font-weight: bold;
  color: #667eea;
  line-height: 1;
  margin-bottom: 1rem;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
}

.not-found h1 {
  color: #333;
  margin-bottom: 1rem;
  font-size: 2rem;
}

.not-found p {
  color: #666;
  margin-bottom: 2rem;
  font-size: 1.1rem;
  line-height: 1.6;
}

.actions {
  display: flex;
  gap: 1rem;
  justify-content: center;
  margin-bottom: 3rem;
}

.btn-secondary {
  background: #6c757d;
}

.btn-secondary:hover {
  background: #5a6268;
}

.demo-info {
  background: #f8f9fa;
  border: 1px solid #e9ecef;
  border-radius: 8px;
  padding: 1.5rem;
  text-align: left;
}

.demo-info h3 {
  color: #667eea;
  margin-bottom: 1rem;
}

.demo-info p {
  color: #666;
  margin-bottom: 1rem;
}

.demo-info ul {
  list-style: none;
  padding: 0;
}

.demo-info li {
  padding: 0.25rem 0;
  color: #555;
  position: relative;
  padding-left: 1.5rem;
}

.demo-info li::before {
  content: "•";
  color: #667eea;
  font-weight: bold;
  position: absolute;
  left: 0;
}

@media (max-width: 768px) {
  .error-code {
    font-size: 6rem;
  }

  .actions {
    flex-direction: column;
    align-items: center;
  }
}
</style>
