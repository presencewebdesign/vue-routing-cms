<template>
  <PageLayout>
    <h1>Contact Us</h1>
    <p>
      Get in touch with us to learn more about implementing CMS-controlled
      routing in your applications.
    </p>

    <div class="contact-content">
      <div class="contact-info">
        <h2>Contact Information</h2>
        <div class="contact-item">
          <h4>📧 Email</h4>
          <p>info@routingcms.com</p>
        </div>
        <div class="contact-item">
          <h4>📱 Phone</h4>
          <p>+1 (555) 123-4567</p>
        </div>
        <div class="contact-item">
          <h4>📍 Address</h4>
          <p>123 Tech Street<br />Innovation City, IC 12345</p>
        </div>
      </div>

      <div class="contact-form">
        <h2>Send us a Message</h2>
        <form @submit.prevent="submitForm">
          <div class="form-group">
            <label for="name">Name</label>
            <input type="text" id="name" v-model="form.name" required />
          </div>

          <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" v-model="form.email" required />
          </div>

          <div class="form-group">
            <label for="subject">Subject</label>
            <input type="text" id="subject" v-model="form.subject" required />
          </div>

          <div class="form-group">
            <label for="message">Message</label>
            <textarea
              id="message"
              v-model="form.message"
              rows="5"
              required
            ></textarea>
          </div>

          <button type="submit" class="btn">Send Message</button>
        </form>
      </div>
    </div>
  </PageLayout>
</template>

<script>
import { reactive } from "vue";
import PageLayout from "../PageLayout.vue";

export default {
  name: "Contact",
  components: {
    PageLayout,
  },
  setup() {
    const form = reactive({
      name: "",
      email: "",
      subject: "",
      message: "",
    });

    const submitForm = () => {
      // In a real application, this would send the form data to your backend
      alert(
        "Thank you for your message! This is a demo - in a real app, this would be sent to your backend."
      );

      // Reset form
      form.name = "";
      form.email = "";
      form.subject = "";
      form.message = "";
    };

    return {
      form,
      submitForm,
    };
  },
};
</script>

<style scoped>
.contact-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
  margin-top: 2rem;
}

.contact-info h2,
.contact-form h2 {
  color: #667eea;
  margin-bottom: 1.5rem;
}

.contact-item {
  margin-bottom: 1.5rem;
}

.contact-item h4 {
  color: #667eea;
  margin-bottom: 0.5rem;
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

.form-group input,
.form-group textarea {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid #ddd;
  border-radius: 5px;
  font-size: 1rem;
  transition: border-color 0.3s ease;
}

.form-group input:focus,
.form-group textarea:focus {
  outline: none;
  border-color: #667eea;
}

.form-group textarea {
  resize: vertical;
}

@media (max-width: 768px) {
  .contact-content {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
}
</style>
