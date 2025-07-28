<template>
  <PageLayout>
    <h1>Our Services</h1>
    <p>
      We provide comprehensive services to help you implement and manage
      CMS-controlled routing solutions.
    </p>

    <div class="services-grid">
      <div class="service-card" v-for="service in services" :key="service.id">
        <div class="service-icon">{{ service.icon }}</div>
        <div class="service-content">
          <h3>{{ service.name }}</h3>
          <p>{{ service.description }}</p>
          <ul class="service-features">
            <li v-for="feature in service.features" :key="feature">
              {{ feature }}
            </li>
          </ul>
          <div class="service-price">{{ service.price }}</div>
        </div>
      </div>
    </div>

    <div class="process-section">
      <h2>Our Implementation Process</h2>
      <div class="process-steps">
        <div class="step">
          <div class="step-number">1</div>
          <h4>Analysis</h4>
          <p>
            We analyze your current routing structure and identify opportunities
            for CMS control.
          </p>
        </div>
        <div class="step">
          <div class="step-number">2</div>
          <h4>Design</h4>
          <p>
            We design a custom solution that fits your specific needs and
            content management workflow.
          </p>
        </div>
        <div class="step">
          <div class="step-number">3</div>
          <h4>Implementation</h4>
          <p>
            Our team implements the solution with Firebase Firestore integration
            and real-time updates.
          </p>
        </div>
        <div class="step">
          <div class="step-number">4</div>
          <h4>Training</h4>
          <p>
            We provide comprehensive training for your content team on managing
            routes through the CMS.
          </p>
        </div>
      </div>
    </div>
  </PageLayout>
</template>

<script>
import { ref } from "vue";
import PageLayout from "../PageLayout.vue";

export default {
  name: "Services",
  components: {
    PageLayout,
  },
  setup() {
    const services = ref([
      {
        id: 1,
        name: "Route Migration",
        icon: "🔄",
        description:
          "Migrate your existing static routes to dynamic CMS-controlled routing.",
        features: [
          "Audit current routing structure",
          "Design migration strategy",
          "Implement gradual rollout",
          "Monitor performance metrics",
        ],
        price: "From $2,500",
      },
      {
        id: 2,
        name: "Custom CMS Development",
        icon: "⚙️",
        description:
          "Build custom content management interfaces for your specific routing needs.",
        features: [
          "User-friendly admin interface",
          "Role-based permissions",
          "Workflow automation",
          "Version control and rollback",
        ],
        price: "From $5,000",
      },
      {
        id: 3,
        name: "Performance Optimization",
        icon: "🚀",
        description:
          "Optimize your routing system for maximum speed and user experience.",
        features: [
          "Caching strategies",
          "CDN integration",
          "Database optimization",
          "Load testing and monitoring",
        ],
        price: "From $1,500",
      },
      {
        id: 4,
        name: "Ongoing Support",
        icon: "🛠️",
        description:
          "Continuous support and maintenance for your routing infrastructure.",
        features: [
          "24/7 monitoring",
          "Regular updates and patches",
          "Performance reporting",
          "Emergency response team",
        ],
        price: "From $500/month",
      },
    ]);

    return {
      services,
    };
  },
};
</script>

<style scoped>
.services-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2rem;
  margin: 2rem 0;
}

.service-card {
  background: white;
  border-radius: 10px;
  padding: 2rem;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.service-card:hover {
  transform: translateY(-3px);
}

.service-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.service-content h3 {
  color: #667eea;
  margin-bottom: 0.5rem;
  font-size: 1.3rem;
}

.service-content p {
  color: #666;
  margin-bottom: 1rem;
  line-height: 1.6;
}

.service-features {
  list-style: none;
  padding: 0;
  margin-bottom: 1.5rem;
}

.service-features li {
  padding: 0.25rem 0;
  color: #555;
  position: relative;
  padding-left: 1.5rem;
}

.service-features li::before {
  content: "✓";
  color: #667eea;
  font-weight: bold;
  position: absolute;
  left: 0;
}

.service-price {
  font-size: 1.2rem;
  font-weight: bold;
  color: #667eea;
}

.process-section {
  margin-top: 3rem;
}

.process-section h2 {
  color: #667eea;
  margin-bottom: 2rem;
  text-align: center;
}

.process-steps {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
}

.step {
  text-align: center;
  padding: 1.5rem;
}

.step-number {
  width: 50px;
  height: 50px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.5rem;
  font-weight: bold;
  margin: 0 auto 1rem auto;
}

.step h4 {
  color: #667eea;
  margin-bottom: 0.5rem;
}

.step p {
  color: #666;
  line-height: 1.6;
}
</style>
