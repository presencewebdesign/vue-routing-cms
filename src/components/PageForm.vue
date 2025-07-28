<template>
  <form @submit.prevent="$emit('submit')">
    <div class="form-group">
      <label :for="titleId">Page Title</label>
      <input
        type="text"
        :id="titleId"
        :value="modelValue.title"
        @input="
          $emit('update:modelValue', {
            ...modelValue,
            title: $event.target.value,
          })
        "
        placeholder="About Us"
        required
      />
    </div>

    <div class="form-group">
      <label :for="pathId">URL Path</label>
      <input
        type="text"
        :id="pathId"
        :value="modelValue.path"
        @input="
          $emit('update:modelValue', {
            ...modelValue,
            path: $event.target.value,
          })
        "
        placeholder="/about"
        required
      />
    </div>

    <ComponentSelector
      :modelValue="modelValue.component"
      :id="componentId"
      @update:modelValue="
        (value) =>
          $emit('update:modelValue', { ...modelValue, component: value })
      "
    />

    <PageSettings
      :modelValue="modelValue"
      :orderId="orderId"
      @update:modelValue="$emit('update:modelValue', $event)"
    />

    <div class="form-actions">
      <button type="submit" class="btn" :disabled="submitting">
        {{ submitText }}
      </button>
      <button
        v-if="showCancel"
        type="button"
        @click="$emit('cancel')"
        class="btn btn-secondary"
      >
        Cancel
      </button>
    </div>
  </form>
</template>

<script>
import ComponentSelector from "./ComponentSelector.vue";
import PageSettings from "./PageSettings.vue";

export default {
  name: "PageForm",
  components: {
    ComponentSelector,
    PageSettings,
  },
  props: {
    modelValue: {
      type: Object,
      required: true,
      default: () => ({
        title: "",
        path: "",
        component: "",
        order: 1,
        visible: true,
        active: true,
      }),
    },
    submitting: {
      type: Boolean,
      default: false,
    },
    submitText: {
      type: String,
      default: "Submit",
    },
    showCancel: {
      type: Boolean,
      default: false,
    },
    titleId: {
      type: String,
      default: "title",
    },
    pathId: {
      type: String,
      default: "path",
    },
    componentId: {
      type: String,
      default: "component",
    },
    orderId: {
      type: String,
      default: "order",
    },
  },
  emits: ["update:modelValue", "submit", "cancel"],
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

.form-group input[type="text"] {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid #ddd;
  border-radius: 5px;
  font-size: 1rem;
}

.form-actions {
  display: flex;
  gap: 0.5rem;
  margin-top: 1.5rem;
}

.btn {
  padding: 0.75rem 1.5rem;
  border: none;
  border-radius: 5px;
  font-size: 1rem;
  cursor: pointer;
  background: #667eea;
  color: white;
  transition: background-color 0.3s ease;
}

.btn:hover {
  background: #5a67d8;
}

.btn:disabled {
  background: #ccc;
  cursor: not-allowed;
}

.btn-secondary {
  background: #6c757d;
}

.btn-secondary:hover {
  background: #5a6268;
}
</style>
