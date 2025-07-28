<template>
  <div class="page">
    <div class="container">
      <slot />
    </div>
  </div>
</template>

<script>
export default {
  name: "PageLayout",
};
</script>

<style scoped>
.page {
  min-height: calc(100vh - 80px);
  padding: 2rem 0;
  background: #f8f9fa;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
}

@media (max-width: 768px) {
  .page {
    padding: 1rem 0;
  }

  .container {
    padding: 0 0.5rem;
  }
}
</style>
