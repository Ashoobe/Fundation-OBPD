# Architecture Documentation

## System Overview

This is a full-stack web application built with Ruby/Sinatra and SQLite, featuring a public website and an administrative CMS dashboard.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                        USER BROWSER                              │
│  ┌──────────────────────────┐  ┌───────────────────────────┐   │
│  │   Public Website         │  │   Admin Dashboard         │   │
│  │   (HTML/CSS/JS)          │  │   (HTML/CSS/JS)           │   │
│  └──────────────────────────┘  └───────────────────────────┘   │
└───────────────────┬──────────────────────────┬──────────────────┘
                    │                          │
                    ├──────────────────────────┤
                    │      HTTP Requests       │
                    └──────────┬───────────────┘
                               │
┌──────────────────────────────▼─────────────────────────────────┐
│                      WEB SERVER (Puma)                          │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │              Sinatra Application (app.rb)                │  │
│  │  ┌────────────────────────────────────────────────────┐  │  │
│  │  │           Routes & Controllers                     │  │  │
│  │  │  • Public Routes  (/, /news, /page/:slug)          │  │  │
│  │  │  • Admin Routes   (/admin/*, /admin/api/*)         │  │  │
│  │  │  • Authentication (login, sessions)                │  │  │
│  │  └─────────────────────┬──────────────────────────────┘  │  │
│  │                        │                                  │  │
│  │  ┌─────────────────────▼──────────────────────────────┐  │  │
│  │  │            Business Logic Layer                    │  │  │
│  │  │  • Helper Methods (authentication, permissions)    │  │  │
│  │  │  • Session Management                              │  │  │
│  │  │  • Request/Response Processing                     │  │  │
│  │  └─────────────────────┬──────────────────────────────┘  │  │
│  └────────────────────────┼──────────────────────────────────┘  │
└───────────────────────────┼─────────────────────────────────────┘
                            │
┌───────────────────────────▼─────────────────────────────────────┐
│                    ActiveRecord (ORM)                            │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                        Models                            │  │
│  │  ┌──────────┐  ┌──────────┐  ┌───────────┐  ┌────────┐ │  │
│  │  │   User   │  │   Page   │  │ MenuItem  │  │  News  │ │  │
│  │  └──────────┘  └──────────┘  └───────────┘  └────────┘ │  │
│  │  ┌──────────┐  ┌──────────┐  ┌───────────┐             │  │
│  │  │  Image   │  │ Setting  │  │  Contact  │             │  │
│  │  └──────────┘  └──────────┘  └───────────┘             │  │
│  └─────────────────────┬────────────────────────────────────┘  │
└───────────────────────┼───────────────────────────────────────┘
                        │
┌───────────────────────▼───────────────────────────────────────┐
│                   SQLite Database                              │
│  ┌──────────────────────────────────────────────────────────┐ │
│  │                        Tables                            │ │
│  │  users | pages | menu_items | news_articles             │ │
│  │  images | settings | contact_submissions                │ │
│  └──────────────────────────────────────────────────────────┘ │
└────────────────────────────────────────────────────────────────┘

```

## Component Details

### 1. Frontend Layer

#### Public Website
**Technology:** HTML (ERB), CSS, Vanilla JavaScript

**Components:**
- `views/layout.erb` - Main layout template
- `views/index.erb` - Homepage
- `views/page.erb` - Generic page template
- `views/news.erb` - News listing
- `views/contact.erb` - Contact form
- `js/main.js` - Frontend JavaScript

**Responsibilities:**
- Render pages to users
- Handle form submissions
- Provide responsive UI
- Client-side validation

#### Admin Dashboard
**Technology:** HTML (ERB), CSS, Vanilla JavaScript

**Components:**
- `views/admin_layout.erb` - Admin layout
- `views/admin_login.erb` - Login page
- `views/admin_dashboard.erb` - Dashboard
- `js/admin.js` - Admin JavaScript

**Responsibilities:**
- Authenticate administrators
- Provide content management interface
- WYSIWYG editing
- Theme customization
- User management

### 2. Application Layer

#### Sinatra Application
**File:** `app.rb`

**Responsibilities:**
- Route handling
- Request processing
- Response generation
- Session management
- Authentication/Authorization

**Key Routes:**
```ruby
# Public Routes
GET  /                    # Homepage
GET  /page/:slug          # Dynamic pages
GET  /news                # News listing
GET  /news/:id            # News article
GET  /contact             # Contact form
POST /contact             # Submit contact

# Admin Routes
GET  /admin/login         # Login page
POST /admin/login         # Process login
GET  /admin               # Dashboard
GET  /admin/api/pages     # Get pages (JSON)
POST /admin/api/pages     # Create page (JSON)
PUT  /admin/api/pages/:id # Update page (JSON)
DELETE /admin/api/pages/:id # Delete page (JSON)
# ... similar routes for other resources
```

### 3. Data Layer

#### Models
**Location:** `models/`

**Seven Core Models:**

1. **User** (`models/user.rb`)
   - Handles authentication
   - Password hashing with BCrypt
   - Role management (admin, editor, viewer)

2. **Page** (`models/page.rb`)
   - Website page content
   - Hierarchical structure (parent/child)
   - Slug generation
   - Publishing workflow

3. **MenuItem** (`models/menu_item.rb`)
   - Navigation structure
   - Dropdown support
   - Position ordering
   - Links to pages or external URLs

4. **NewsArticle** (`models/news_article.rb`)
   - News content
   - Image support
   - Publishing dates
   - Status (published/draft)

5. **Image** (`models/image.rb`)
   - Media library
   - Category tagging
   - Alt text for accessibility

6. **Setting** (`models/setting.rb`)
   - Key-value configuration
   - Theme settings
   - Site preferences

7. **ContactSubmission** (`models/contact_submission.rb`)
   - Contact form entries
   - Read/unread status
   - Timestamp tracking

#### Database Schema
**File:** `db/migrate/001_create_schema.rb`

**Relationships:**
```
users (1) ──┬── pages (N) [created_by]
            └── news_articles (N) [created_by]

pages (1) ──── menu_items (N) [page_id]
      └───┬─── pages (N) [parent_id] (self-referential)
          
menu_items (1) ── menu_items (N) [parent_id] (self-referential)
```

## Data Flow

### Public Page Request
```
1. User requests page: GET /page/about
2. Sinatra routes to page handler
3. Handler queries Page.find_by(slug: 'about')
4. Page model queries database
5. Returns page object
6. Handler renders page.erb with @page
7. ERB template generates HTML
8. HTML sent to browser
```

### Admin Page Edit
```
1. Admin edits page in dashboard
2. JavaScript sends: PUT /admin/api/pages/5
3. Sinatra authenticates user
4. Checks user.can_edit?
5. Updates Page model
6. Page model updates database
7. Returns success JSON
8. JavaScript updates UI
```

### Contact Form Submission
```
1. User submits form: POST /contact
2. Sinatra validates input
3. Creates ContactSubmission record
4. Saves to database
5. Redirects to /contact?success=1
6. Success message displayed
```

## Security Architecture

### Authentication Flow
```
1. User submits login form
2. Find user by username
3. Verify password with BCrypt
4. Create session
5. Store user_id in session
6. Set session cookie
7. User authenticated
```

### Authorization Checks
```ruby
# Every admin route checks:
require_login  # Ensures session[:user_id] exists
require_admin  # Ensures user.role == 'admin'

# Edit operations check:
current_user.can_edit?  # admin or editor role
```

### Password Security
- Passwords hashed with BCrypt
- Salt automatically generated
- Never stored in plain text
- Compared using secure algorithm

## File Serving

### Static Assets
```
Request: /css/global/layout.css
         ↓
Sinatra checks: public/css/global/layout.css
         ↓
File exists: Serve directly
File missing: 404 error
```

### Dynamic Content
```
Request: /page/about
         ↓
Sinatra routes to handler
         ↓
Query database for page
         ↓
Render ERB template
         ↓
Return generated HTML
```

## CSS Architecture

### Cascade Order
```
1. reset.css       # Reset browser defaults
2. variables.css   # Define CSS custom properties
3. layout.css      # Site structure and layout
4. components.css  # Reusable components
5. home.css        # Page-specific styles
6. news.css        # Page-specific styles
7. contact.css     # Page-specific styles
8. admin.css       # Admin-specific styles
9. tablet.css      # Tablet breakpoints
10. mobile.css     # Mobile breakpoints
```

### CSS Variables
```css
:root {
  --primary-color: #2C5F2D;    /* Set via theme customizer */
  --secondary-color: #97BC62;   /* Set via theme customizer */
  --font-family: Arial;         /* Set via theme customizer */
}
```

## JavaScript Architecture

### Main.js (Public Site)
```javascript
// Module structure:
- Mobile menu toggle
- Smooth scrolling
- Form validation
- Dropdown menus
- API utilities
```

### Admin.js (Dashboard)
```javascript
// Module structure:
- Dashboard loader
- Page manager (CRUD)
- News manager (CRUD)
- Theme customizer
- Modal dialogs
- Editor toolbar
- API integration
```

## Deployment Architecture

### Development
```
Developer Machine
├── Ruby 3.2.1
├── SQLite (local file)
├── Puma web server
└── localhost:3000
```

### Production (Render.com)
```
Render Platform
├── Ruby environment
├── SQLite (persistent disk)
├── Puma web server
├── Auto SSL
└── your-app.onrender.com
```

### Production (VPS)
```
Server (Ubuntu)
├── Ruby 3.2.1 (rbenv)
├── SQLite
├── Puma (systemd)
├── Nginx (reverse proxy)
├── Let's Encrypt SSL
└── your-domain.com
```

## Performance Considerations

### Database Queries
- Indexed fields (slug, username, key)
- Eager loading for associations
- Scopes for common queries

### Caching Strategy
- Static assets served directly by web server
- Session data in memory
- Database queries not cached (small dataset)

### Asset Optimization
- Minify CSS in production
- Combine JavaScript files
- Compress images
- Enable Gzip

## Scalability

### Current Capacity
- Handles hundreds of concurrent users
- Thousands of pages
- Thousands of news articles
- Suitable for most foundation websites

### Upgrade Path
If you need more:
1. **Database:** Switch SQLite → PostgreSQL
2. **Server:** Add more Puma workers
3. **Caching:** Add Redis for sessions
4. **CDN:** Serve static assets from CDN
5. **Load Balancer:** Multiple app servers

## Development Workflow

### Local Development
```
1. Edit code
2. Restart server (if Ruby changes)
3. Refresh browser (if views/assets)
4. Test in browser
5. Commit to git
```

### Database Changes
```
1. Create migration
2. Run: rake db:migrate
3. Update models if needed
4. Test changes
5. Commit migration
```

### Theme Changes
```
1. Edit CSS files
2. Or use Theme Customizer
3. Changes apply immediately
4. Test responsive design
```

## Monitoring & Debugging

### Logs
```
Development: Terminal output
Production: log/production.log
Database: SQLite has no separate logs
```

### Debug Tools
```
Browser DevTools: JavaScript, Network, CSS
Ruby: binding.pry (if needed)
Database: sqlite3 command line
```

## Technology Stack Summary

| Layer | Technology | Purpose |
|-------|-----------|---------|
| Frontend | HTML5, CSS3, JavaScript (ES6) | User interface |
| Templates | ERB (Embedded Ruby) | Dynamic HTML generation |
| Framework | Sinatra 3.0 | Web application framework |
| ORM | ActiveRecord 7.0 | Database abstraction |
| Database | SQLite 3 | Data storage |
| Server | Puma 5.0 | Application server |
| Security | BCrypt | Password hashing |
| Testing | RSpec | Testing framework |

## Integration Points

### External Services (Ready for Integration)

1. **Email Service**
   - Contact form notifications
   - User password resets
   - Newsletter integration

2. **Payment Processing**
   - Donation forms
   - Event registration
   - Merchandise sales

3. **Social Media**
   - Auto-post news to Facebook
   - Tweet new articles
   - Instagram feed display

4. **Analytics**
   - Google Analytics
   - User behavior tracking
   - Conversion tracking

5. **Storage**
   - AWS S3 for images
   - CDN for assets
   - Backup services

## API Documentation

### Admin REST API

All API endpoints return JSON and require authentication.

**Base URL:** `/admin/api`

**Authentication:** Session-based (cookie)

**Endpoints:**

```
GET    /admin/api/pages           # List all pages
POST   /admin/api/pages           # Create page
GET    /admin/api/pages/:id       # Get page
PUT    /admin/api/pages/:id       # Update page
DELETE /admin/api/pages/:id       # Delete page

GET    /admin/api/menu_items      # List menu items
GET    /admin/api/news            # List news articles
GET    /admin/api/settings        # List settings
POST   /admin/api/settings        # Update setting
```

**Response Format:**
```json
{
  "id": 1,
  "title": "About Us",
  "slug": "about-us",
  "content": "<p>Content here</p>",
  "published": true,
  "created_at": "2024-01-01T00:00:00Z"
}
```

## Error Handling

### Application Errors
- Caught by Sinatra
- Logged to console/file
- User-friendly error pages

### Database Errors
- Validation errors shown to user
- Connection errors logged
- Transactions for data integrity

### Authentication Errors
- Redirect to login page
- Clear error messages
- No sensitive info leaked

## Backup Strategy

### Development
```bash
# Backup database
cp db/development.sqlite3 backups/$(date +%Y%m%d).sqlite3
```

### Production
```bash
# Automated daily backups
0 2 * * * cp /app/db/production.sqlite3 /backups/$(date +%Y%m%d).sqlite3
```

### What to Backup
1. Database file (most important)
2. Uploaded images (public/images/)
3. Configuration files
4. Custom code changes

## Conclusion

This architecture provides:
- ✅ Separation of concerns
- ✅ Scalable structure
- ✅ Maintainable codebase
- ✅ Secure implementation
- ✅ Production-ready deployment
- ✅ Easy to understand and modify

The system is designed to be:
- **Simple** - No unnecessary complexity
- **Robust** - Proper error handling
- **Secure** - Security best practices
- **Maintainable** - Well-organized code
- **Documented** - Comprehensive documentation

For more details, see the other documentation files!
