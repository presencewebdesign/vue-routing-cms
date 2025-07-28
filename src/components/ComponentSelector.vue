<template>
  <div class="form-group">
    <label :for="id">Component Name</label>
    <select
      :id="id"
      :value="modelValue"
      @change="$emit('update:modelValue', $event.target.value)"
      required
    >
      <option value="">Select a component</option>
      <option value="Home">Home</option>
      <option value="About">About (Dynamic)</option>
      <option value="Contact">Contact (Dynamic)</option>
      <option value="Products">Products (Dynamic)</option>
      <option value="Services">Services (Dynamic)</option>
    </select>
    <small class="form-help">Choose a component to render for this page</small>
  </div>
</template>

<script>
export default {
  name: "ComponentSelector",
  props: {
    modelValue: {
      type: String,
      default: "",
    },
    id: {
      type: String,
      default: "component",
    },
  },
  emits: ["update:modelValue"],
};
</script>

<style scoped>
.form-group {
  margin-bottom: 1.5rem;
}

.form-group label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: 500;
  color: #333;
}

.form-group select {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid #ddd;
  border-radius: 5px;
  font-size: 1rem;
  background: white;
}

.form-help {
  color: #666;
  font-size: 0.9rem;
  margin-top: 0.25rem;
}
</style>
