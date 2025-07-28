<template>
  <PageLayout>
    <h1>Our Products</h1>
    <p>
      Explore our range of products that demonstrate the power of CMS-controlled
      routing and dynamic content management.
    </p>

    <div class="products-grid">
      <div class="product-card" v-for="product in products" :key="product.id">
        <div class="product-image">
          <div class="image-placeholder">{{ product.emoji }}</div>
        </div>
        <div class="product-content">
          <h3>{{ product.name }}</h3>
          <p>{{ product.description }}</p>
          <div class="product-price">${{ product.price }}</div>
          <button class="btn">Learn More</button>
        </div>
      </div>
    </div>

    <div class="demo-note">
      <h3>💡 Demo Note</h3>
      <p>
        This products page demonstrates how content can be dynamically loaded
        from Firebase Firestore. In a real application, the product data would
        be stored in the database and updated through the CMS.
      </p>
    </div>
  </PageLayout>
</template>

<script>
import { ref } from "vue";
import PageLayout from "../PageLayout.vue";

export default {
  name: "Products",
  components: {
    PageLayout,
  },
  setup() {
    const products = ref([
      {
        id: 1,
        name: "Dynamic Routing System",
        description:
          "A complete solution for CMS-controlled routing with real-time updates and seamless user experience.",
        price: 299,
        emoji: "🛣️",
      },
      {
        id: 2,
        name: "Content Management Suite",
        description:
          "Comprehensive CMS tools for managing routes, content, and user navigation dynamically.",
        price: 199,
        emoji: "📝",
      },
      {
        id: 3,
        name: "Real-time Analytics",
        description:
          "Track user navigation patterns and route performance with live analytics dashboard.",
        price: 149,
        emoji: "📊",
      },
      {
        id: 4,
        name: "API Integration Kit",
        description:
          "Easy integration with existing systems and third-party services for enhanced functionality.",
        price: 99,
        emoji: "🔌",
      },
      {
        id: 5,
        name: "Custom Theme Builder",
        description:
          "Create beautiful, responsive themes that work seamlessly with dynamic routing.",
        price: 179,
        emoji: "🎨",
      },
      {
        id: 6,
        name: "Enterprise Support",
        description:
          "24/7 support and consultation for enterprise-level routing and content management needs.",
        price: 499,
        emoji: "🏢",
      },
    ]);

    return {
      products,
    };
  },
};
</script>

<style scoped>
.products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin: 2rem 0;
}

.product-card {
  background: white;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.product-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}

.product-image {
  height: 200px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  display: flex;
  align-items: center;
  justify-content: center;
}

.image-placeholder {
  font-size: 4rem;
  color: white;
}

.product-content {
  padding: 1.5rem;
}

.product-content h3 {
  color: #667eea;
  margin-bottom: 0.5rem;
  font-size: 1.2rem;
}

.product-content p {
  color: #666;
  margin-bottom: 1rem;
  line-height: 1.6;
}

.product-price {
  font-size: 1.5rem;
  font-weight: bold;
  color: #667eea;
  margin-bottom: 1rem;
}

.demo-note {
  background: #fff3cd;
  border: 1px solid #ffeaa7;
  border-radius: 8px;
  padding: 1.5rem;
  margin-top: 2rem;
}

.demo-note h3 {
  color: #856404;
  margin-bottom: 0.5rem;
}

.demo-note p {
  color: #856404;
  margin: 0;
}
</style>
