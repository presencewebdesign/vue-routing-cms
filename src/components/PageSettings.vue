<template>
  <div class="page-settings">
    <div class="form-group">
      <label :for="orderId">Navigation Order</label>
      <input
        type="number"
        :id="orderId"
        :value="modelValue.order"
        @input="
          $emit('update:modelValue', {
            ...modelValue,
            order: parseInt($event.target.value),
          })
        "
        min="1"
        required
      />
    </div>

    <div class="form-group">
      <label>
        <input
          type="checkbox"
          :checked="modelValue.visible"
          @change="
            $emit('update:modelValue', {
              ...modelValue,
              visible: $event.target.checked,
            })
          "
        />
        Visible in Navigation
      </label>
    </div>

    <div class="form-group">
      <label>
        <input
          type="checkbox"
          :checked="modelValue.active"
          @change="
            $emit('update:modelValue', {
              ...modelValue,
              active: $event.target.checked,
            })
          "
        />
        Active Page
      </label>
    </div>
  </div>
</template>

<script>
export default {
  name: "PageSettings",
  props: {
    modelValue: {
      type: Object,
      required: true,
      default: () => ({
        order: 1,
        visible: true,
        active: true,
      }),
    },
    orderId: {
      type: String,
      default: "order",
    },
  },
  emits: ["update:modelValue"],
};
</script>

<style scoped>
.page-settings {
  /* No additional styles needed - uses existing form-group styles */
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

.form-group input[type="number"] {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid #ddd;
  border-radius: 5px;
  font-size: 1rem;
}

.form-group input[type="checkbox"] {
  margin-right: 0.5rem;
}
</style>
