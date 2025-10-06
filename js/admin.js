/**
 * Admin Dashboard JavaScript
 * Handles all admin panel functionality including CRUD operations
 */

document.addEventListener('DOMContentLoaded', function() {
  initAdminDashboard();
});

/**
 * Initialize admin dashboard
 */
function initAdminDashboard() {
  const currentPage = window.location.hash || '#dashboard';
  loadAdminPage(currentPage);
  
  // Handle navigation
  document.querySelectorAll('.admin-menu a').forEach(link => {
    link.addEventListener('click', function(e) {
      e.preventDefault();
      const page = this.getAttribute('href');
      loadAdminPage(page);
      
      // Update active state
      document.querySelectorAll('.admin-menu a').forEach(l => l.classList.remove('active'));
      this.classList.add('active');
    });
  });
}

/**
 * Load admin page content
 */
async function loadAdminPage(page) {
  const contentArea = document.getElementById('admin-main-content');
  if (!contentArea) return;
  
  switch(page) {
    case '#dashboard':
      await loadDashboard(contentArea);
      break;
    case '#pages':
      await loadPagesManager(contentArea);
      break;
    case '#menus':
      await loadMenusManager(contentArea);
      break;
    case '#news':
      await loadNewsManager(contentArea);
      break;
    case '#users':
      await loadUsersManager(contentArea);
      break;
    case '#theme':
      await loadThemeCustomizer(contentArea);
      break;
    case '#images':
      await loadImageManager(contentArea);
      break;
    case '#settings':
      await loadSettings(contentArea);
      break;
    default:
      contentArea.innerHTML = '<h2>Page not found</h2>';
  }
}

/**
 * Load dashboard with statistics
 */
async function loadDashboard(container) {
  try {
    const [pages, news] = await Promise.all([
      apiCall('/admin/api/pages'),
      apiCall('/admin/api/news')
    ]);
    
    container.innerHTML = `
      <h2 class="admin-title">Dashboard</h2>
      <div class="stats-grid">
        <div class="stat-box">
          <div class="stat-value">${pages.length}</div>
          <div class="stat-label">Total Pages</div>
        </div>
        <div class="stat-box">
          <div class="stat-value">${news.length}</div>
          <div class="stat-label">News Articles</div>
        </div>
        <div class="stat-box">
          <div class="stat-value">${news.filter(n => n.published).length}</div>
          <div class="stat-label">Published</div>
        </div>
      </div>
      <div class="admin-card">
        <div class="admin-card-header">
          <h3 class="admin-card-title">Recent Activity</h3>
        </div>
        <p>Welcome to the Oak Brook Park District Foundation admin dashboard.</p>
        <p>Use the menu on the left to manage your website content.</p>
      </div>
    `;
  } catch (error) {
    container.innerHTML = '<div class="alert alert-error">Failed to load dashboard</div>';
  }
}

/**
 * Load pages manager
 */
async function loadPagesManager(container) {
  try {
    const pages = await apiCall('/admin/api/pages');
    
    let html = `
      <div class="admin-header">
        <h2 class="admin-title">Pages Manager</h2>
        <button class="btn" onclick="showPageEditor()">Add New Page</button>
      </div>
      <div class="admin-card">
        <table class="admin-table">
          <thead>
            <tr>
              <th>Title</th>
              <th>Slug</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
    `;
    
    pages.forEach(page => {
      html += `
        <tr>
          <td>${escapeHtml(page.title)}</td>
          <td>${escapeHtml(page.slug)}</td>
          <td>${page.published ? '✓ Published' : '✗ Draft'}</td>
          <td class="actions">
            <button class="btn btn-small" onclick="editPage(${page.id})">Edit</button>
            <button class="btn btn-small btn-secondary" onclick="deletePage(${page.id})">Delete</button>
          </td>
        </tr>
      `;
    });
    
    html += `
          </tbody>
        </table>
      </div>
    `;
    
    container.innerHTML = html;
  } catch (error) {
    container.innerHTML = '<div class="alert alert-error">Failed to load pages</div>';
  }
}

/**
 * Show page editor modal
 */
function showPageEditor(pageId = null) {
  const modal = createModal('Page Editor');
  
  const form = document.createElement('form');
  form.innerHTML = `
    <div class="form-group">
      <label class="form-label">Title</label>
      <input type="text" name="title" class="form-input" required>
    </div>
    <div class="form-group">
      <label class="form-label">Slug</label>
      <input type="text" name="slug" class="form-input" required>
    </div>
    <div class="form-group">
      <label class="form-label">Content</label>
      <div class="editor-container">
        <div class="editor-toolbar">
          <button type="button" class="editor-button" onclick="formatText('bold')"><strong>B</strong></button>
          <button type="button" class="editor-button" onclick="formatText('italic')"><em>I</em></button>
          <button type="button" class="editor-button" onclick="formatText('underline')"><u>U</u></button>
        </div>
        <div class="editor-content" contenteditable="true" id="page-content"></div>
      </div>
    </div>
    <div class="form-group">
      <label class="form-label">
        <input type="checkbox" name="published"> Published
      </label>
    </div>
    <button type="submit" class="btn">Save Page</button>
  `;
  
  if (pageId) {
    // Load existing page data
    apiCall(`/admin/api/pages/${pageId}`).then(page => {
      form.title.value = page.title;
      form.slug.value = page.slug;
      document.getElementById('page-content').innerHTML = page.content || '';
      form.published.checked = page.published;
    });
  }
  
  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const data = {
      title: form.title.value,
      slug: form.slug.value,
      content: document.getElementById('page-content').innerHTML,
      published: form.published.checked
    };
    
    try {
      if (pageId) {
        await apiCall(`/admin/api/pages/${pageId}`, 'PUT', data);
      } else {
        await apiCall('/admin/api/pages', 'POST', data);
      }
      closeModal();
      loadAdminPage('#pages');
    } catch (error) {
      alert('Failed to save page');
    }
  });
  
  modal.querySelector('.modal-content').appendChild(form);
  document.body.appendChild(modal);
}

/**
 * Edit page
 */
function editPage(id) {
  showPageEditor(id);
}

/**
 * Delete page
 */
async function deletePage(id) {
  if (!confirm('Are you sure you want to delete this page?')) {
    return;
  }
  
  try {
    await apiCall(`/admin/api/pages/${id}`, 'DELETE');
    loadAdminPage('#pages');
  } catch (error) {
    alert('Failed to delete page');
  }
}

/**
 * Load news manager
 */
async function loadNewsManager(container) {
  try {
    const articles = await apiCall('/admin/api/news');
    
    let html = `
      <div class="admin-header">
        <h2 class="admin-title">News Manager</h2>
        <button class="btn" onclick="showNewsEditor()">Add News Article</button>
      </div>
      <div class="admin-card">
        <table class="admin-table">
          <thead>
            <tr>
              <th>Title</th>
              <th>Published</th>
              <th>Date</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
    `;
    
    articles.forEach(article => {
      html += `
        <tr>
          <td>${escapeHtml(article.title)}</td>
          <td>${article.published ? '✓' : '✗'}</td>
          <td>${new Date(article.published_at).toLocaleDateString()}</td>
          <td class="actions">
            <button class="btn btn-small" onclick="editNews(${article.id})">Edit</button>
            <button class="btn btn-small btn-secondary" onclick="deleteNews(${article.id})">Delete</button>
          </td>
        </tr>
      `;
    });
    
    html += `
          </tbody>
        </table>
      </div>
    `;
    
    container.innerHTML = html;
  } catch (error) {
    container.innerHTML = '<div class="alert alert-error">Failed to load news</div>';
  }
}

/**
 * Load theme customizer
 */
async function loadThemeCustomizer(container) {
  try {
    const settings = await apiCall('/admin/api/settings');
    const settingsMap = {};
    settings.forEach(s => settingsMap[s.key] = s.value);
    
    container.innerHTML = `
      <div class="admin-header">
        <h2 class="admin-title">Theme Customizer</h2>
      </div>
      <div class="admin-card">
        <h3>Colors</h3>
        <div class="color-picker-group">
          <div class="form-group">
            <label class="form-label">Primary Color</label>
            <div class="color-picker">
              <input type="color" id="primary-color" value="${settingsMap.primary_color || '#2C5F2D'}">
              <input type="text" class="form-input" value="${settingsMap.primary_color || '#2C5F2D'}">
            </div>
          </div>
          <div class="form-group">
            <label class="form-label">Secondary Color</label>
            <div class="color-picker">
              <input type="color" id="secondary-color" value="${settingsMap.secondary_color || '#97BC62'}">
              <input type="text" class="form-input" value="${settingsMap.secondary_color || '#97BC62'}">
            </div>
          </div>
        </div>
        <h3 style="margin-top: 2rem;">Typography</h3>
        <div class="form-group">
          <label class="form-label">Font Family</label>
          <select class="form-select" id="font-family">
            <option value="Arial, sans-serif">Arial</option>
            <option value="'Helvetica Neue', sans-serif">Helvetica</option>
            <option value="'Roboto', sans-serif">Roboto</option>
            <option value="'Open Sans', sans-serif">Open Sans</option>
          </select>
        </div>
        <button class="btn" onclick="saveTheme()">Save Theme</button>
      </div>
    `;
  } catch (error) {
    container.innerHTML = '<div class="alert alert-error">Failed to load theme settings</div>';
  }
}

/**
 * Save theme settings
 */
async function saveTheme() {
  const primaryColor = document.getElementById('primary-color').value;
  const secondaryColor = document.getElementById('secondary-color').value;
  const fontFamily = document.getElementById('font-family').value;
  
  try {
    await Promise.all([
      apiCall('/admin/api/settings', 'POST', { key: 'primary_color', value: primaryColor }),
      apiCall('/admin/api/settings', 'POST', { key: 'secondary_color', value: secondaryColor }),
      apiCall('/admin/api/settings', 'POST', { key: 'font_family', value: fontFamily })
    ]);
    
    // Update CSS variables
    document.documentElement.style.setProperty('--primary-color', primaryColor);
    document.documentElement.style.setProperty('--secondary-color', secondaryColor);
    document.documentElement.style.setProperty('--font-family', fontFamily);
    
    alert('Theme saved successfully!');
  } catch (error) {
    alert('Failed to save theme');
  }
}

/**
 * Load menus manager (stub)
 */
async function loadMenusManager(container) {
  container.innerHTML = `
    <div class="admin-header">
      <h2 class="admin-title">Menu Manager</h2>
    </div>
    <div class="admin-card">
      <p>Menu management interface coming soon. Menus are currently managed through the database seed file.</p>
    </div>
  `;
}

/**
 * Load users manager (stub)
 */
async function loadUsersManager(container) {
  container.innerHTML = `
    <div class="admin-header">
      <h2 class="admin-title">User Manager</h2>
    </div>
    <div class="admin-card">
      <p>User management interface for creating and managing admin accounts.</p>
      <p>Current admin user: <strong>admin</strong> / <strong>admin123</strong></p>
    </div>
  `;
}

/**
 * Load image manager (stub)
 */
async function loadImageManager(container) {
  container.innerHTML = `
    <div class="admin-header">
      <h2 class="admin-title">Image Manager</h2>
    </div>
    <div class="admin-card">
      <p>Image upload and management interface coming soon.</p>
    </div>
  `;
}

/**
 * Load settings (stub)
 */
async function loadSettings(container) {
  container.innerHTML = `
    <div class="admin-header">
      <h2 class="admin-title">Settings</h2>
    </div>
    <div class="admin-card">
      <h3>Site Settings</h3>
      <p>General site settings and configuration options.</p>
    </div>
  `;
}

/**
 * Create modal dialog
 */
function createModal(title) {
  const modal = document.createElement('div');
  modal.className = 'modal active';
  modal.innerHTML = `
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title">${title}</h3>
        <span class="modal-close" onclick="closeModal()">&times;</span>
      </div>
    </div>
  `;
  return modal;
}

/**
 * Close modal
 */
function closeModal() {
  const modal = document.querySelector('.modal');
  if (modal) {
    modal.remove();
  }
}

/**
 * Format text in editor
 */
function formatText(command) {
  document.execCommand(command, false, null);
}

/**
 * Escape HTML to prevent XSS
 */
function escapeHtml(text) {
  const div = document.createElement('div');
  div.textContent = text;
  return div.innerHTML;
}

/**
 * API call wrapper (uses global function from main.js)
 */
function apiCall(url, method = 'GET', data = null) {
  return window.app.apiCall(url, method, data);
}

// Make functions globally available
window.showPageEditor = showPageEditor;
window.editPage = editPage;
window.deletePage = deletePage;
window.editNews = editNews;
window.deleteNews = deleteNews;
window.saveTheme = saveTheme;
window.closeModal = closeModal;
window.formatText = formatText;

// Placeholder functions
function showNewsEditor() {
  alert('News editor interface coming soon');
}

function editNews() {
  alert('Edit news interface coming soon');
}

function deleteNews() {
  alert('Delete news interface coming soon');
}
