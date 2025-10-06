/**
 * Main JavaScript for Oak Brook Park District Foundation Website
 * Handles navigation, mobile menu, and general interactions
 */

document.addEventListener('DOMContentLoaded', function() {
  // Mobile Menu Toggle
  initMobileMenu();
  
  // Smooth Scrolling for anchor links
  initSmoothScroll();
  
  // Form validation
  initFormValidation();
  
  // Dropdown menus for mobile
  initMobileDropdowns();
});

/**
 * Initialize mobile menu functionality
 */
function initMobileMenu() {
  const menuToggle = document.querySelector('.menu-toggle');
  const nav = document.querySelector('nav ul');
  
  if (menuToggle && nav) {
    menuToggle.addEventListener('click', function() {
      nav.classList.toggle('active');
      this.setAttribute('aria-expanded', nav.classList.contains('active'));
    });
  }
}

/**
 * Initialize smooth scrolling for anchor links
 */
function initSmoothScroll() {
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
      const href = this.getAttribute('href');
      if (href !== '#' && href !== '#!') {
        e.preventDefault();
        const target = document.querySelector(href);
        if (target) {
          target.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
          });
        }
      }
    });
  });
}

/**
 * Initialize form validation
 */
function initFormValidation() {
  const forms = document.querySelectorAll('form[data-validate]');
  
  forms.forEach(form => {
    form.addEventListener('submit', function(e) {
      if (!validateForm(this)) {
        e.preventDefault();
      }
    });
  });
}

/**
 * Validate form fields
 */
function validateForm(form) {
  let isValid = true;
  const requiredFields = form.querySelectorAll('[required]');
  
  requiredFields.forEach(field => {
    if (!field.value.trim()) {
      showError(field, 'This field is required');
      isValid = false;
    } else if (field.type === 'email' && !isValidEmail(field.value)) {
      showError(field, 'Please enter a valid email address');
      isValid = false;
    } else {
      clearError(field);
    }
  });
  
  return isValid;
}

/**
 * Check if email is valid
 */
function isValidEmail(email) {
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return re.test(email);
}

/**
 * Show error message for field
 */
function showError(field, message) {
  clearError(field);
  field.classList.add('error');
  const error = document.createElement('div');
  error.className = 'field-error';
  error.textContent = message;
  field.parentNode.appendChild(error);
}

/**
 * Clear error message for field
 */
function clearError(field) {
  field.classList.remove('error');
  const error = field.parentNode.querySelector('.field-error');
  if (error) {
    error.remove();
  }
}

/**
 * Initialize mobile dropdown menus
 */
function initMobileDropdowns() {
  if (window.innerWidth <= 768) {
    const dropdowns = document.querySelectorAll('.dropdown');
    
    dropdowns.forEach(dropdown => {
      const toggle = dropdown.querySelector('a');
      toggle.addEventListener('click', function(e) {
        if (window.innerWidth <= 768) {
          e.preventDefault();
          dropdown.classList.toggle('active');
        }
      });
    });
  }
}

/**
 * Utility function to make API calls
 */
async function apiCall(url, method = 'GET', data = null) {
  const options = {
    method: method,
    headers: {
      'Content-Type': 'application/json'
    }
  };
  
  if (data) {
    options.body = JSON.stringify(data);
  }
  
  try {
    const response = await fetch(url, options);
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    return await response.json();
  } catch (error) {
    console.error('API call failed:', error);
    throw error;
  }
}

// Export functions for use in other scripts
window.app = {
  apiCall,
  showError,
  clearError,
  validateForm
};
