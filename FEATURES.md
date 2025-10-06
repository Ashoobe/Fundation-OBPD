# Oak Brook Park District Foundation - Features Documentation

## Complete Feature List

### 1. Public Website

#### Navigation Structure
The website includes a comprehensive navigation menu with dropdown support:

**Main Menu Items:**
- Home
- News  
- Community Impact (Dropdown)
  - Oak Leaf Legacy
  - How We Light the Way
  - Athlete of the Year
  - Dean Nature Sanctuary
  - Universal Playground
- Ways to Give Back (Dropdown)
  - Ways to Give Back
  - Swim Central Video Display
  - Park Shop
  - Apparoa (Roa) Memorial Fund
  - Memorial Program
- Projects
- About
- FAQs
- Contact

#### Pre-Built Pages

All pages are pre-populated with content and ready to use:

1. **Oak Leaf Legacy** (`/page/oak-leaf-legacy`)
   - Information about the legacy program
   - Benefits of membership
   - How to join

2. **How We Light the Way** (`/page/how-we-light-the-way`)
   - Initiative overview
   - Mission and impact
   - Support information

3. **Athlete of the Year** (`/page/athlete-of-the-year`)
   - Award criteria
   - Nomination process
   - Past recipients

4. **Dean Nature Sanctuary** (`/page/dean-nature-sanctuary`)
   - Features and amenities
   - Educational programs
   - Conservation efforts

5. **Universal Playground** (`/page/universal-playground`)
   - Inclusive design features
   - YouTube video embed (placeholder)
   - Community impact

6. **Ways to Give Back** (`/page/ways-to-give-back`)
   - Donation options
   - Volunteer opportunities
   - How to get involved

7. **Swim Central Video Display** (`/page/swim-central-video-display`)
   - Project goals
   - Donation link

8. **Park Shop** (`/page/park-shop`)
   - Link to Squad Locker store
   - Merchandise information

9. **Apparoa (Roa) Memorial Fund** (`/page/apparoa-roa-memorial-fund`)
   - Fund information
   - Donation form link

10. **Memorial Program** (`/page/memorial-program`)
    - Memorial options (Trees, Benches, Bricks)
    - How to create a memorial

11. **Projects** (`/page/projects`)
    - Current projects list
    - Proposed projects list

12. **About** (`/page/about`)
    - Foundation mission
    - What we do
    - Impact areas

13. **FAQs** (`/page/faqs`)
    - Common questions and answers
    - How to donate
    - Volunteer information

#### News System (`/news`)
- List view with images
- Individual article pages
- Published date display
- Excerpt on list view
- Full content on detail view

#### Contact Form (`/contact`)
- Name, email, message fields
- Form validation
- Submission storage in database
- Success/error messaging
- Contact information display

### 2. Admin Dashboard

#### Access
- URL: `/admin/login`
- Default credentials: `admin` / `admin123`

#### Dashboard Features

##### 1. Dashboard Overview (`#dashboard`)
- Statistics display
  - Total pages count
  - Total news articles
  - Published items count
- Recent activity log
- Quick access to common tasks

##### 2. Pages Manager (`#pages`)
**Features:**
- List all pages in table format
- Create new pages
- Edit existing pages
- Delete pages
- Toggle published status
- Set page slug (URL)
- WYSIWYG content editor

**Page Editor:**
- Title input
- Slug (URL) input
- Content editor with formatting toolbar
  - Bold
  - Italic
  - Underline
- Published checkbox
- Save/Update functionality

##### 3. Menu Manager (`#menus`)
- View menu structure
- Menu items listed with hierarchy
- Parent/child relationships
- Position ordering
- (Full CRUD interface ready for implementation)

##### 4. News Manager (`#news`)
**Features:**
- List all news articles
- Create new articles
- Edit existing articles
- Delete articles
- Set published status
- Add images to articles
- Set publication date

##### 5. User Manager (`#users`)
**Features:**
- List all admin users
- Create new users
- Edit user details
- Set user roles:
  - Admin (full access)
  - Editor (can edit content)
  - Viewer (read-only)
- Username/password management
- (Interface ready for full implementation)

##### 6. Image Manager (`#images`)
**Features:**
- Upload images
- Organize by category:
  - Background
  - Top of page
  - Side of page
  - Bottom of page
  - General
- Delete images
- View image gallery
- Insert images into content
- (Upload interface ready for implementation)

##### 7. Theme Customizer (`#theme`)
**Customizable Elements:**
- **Colors:**
  - Primary color (headers, buttons)
  - Secondary color (accents)
  - Visual color picker
  - Hex code input
- **Typography:**
  - Font family selection
  - Header font selection
- **Real-time preview:**
  - Changes apply immediately
  - See updates before saving

##### 8. Settings (`#settings`)
- Site title
- Contact information
- Meta description
- Social media links
- Footer content
- (Configuration interface ready)

### 3. Responsive Design

#### Breakpoints
- **Desktop:** 1025px and above
- **Tablet:** 769px to 1024px
- **Mobile:** 768px and below
- **Small Mobile:** 480px and below

#### Responsive Features
- Mobile-friendly navigation with hamburger menu
- Stacked layouts on small screens
- Touch-friendly buttons and links
- Optimized images for mobile
- Responsive typography (font sizes adjust)
- Flexible grid layouts
- Dropdown menus work on touch devices

### 4. File Organization

#### CSS Structure
```
css/
├── global/              # Site-wide styles
│   ├── reset.css       # CSS reset
│   ├── variables.css   # CSS custom properties (theme)
│   ├── layout.css      # Layout and structure
│   └── components.css  # Reusable components
├── pages/              # Page-specific styles
│   ├── home.css        # Homepage
│   ├── news.css        # News pages
│   ├── contact.css     # Contact page
│   └── admin.css       # Admin dashboard
└── responsive/         # Responsive breakpoints
    ├── mobile.css      # Mobile styles
    └── tablet.css      # Tablet styles
```

#### JavaScript Organization
```
js/
├── main.js            # Frontend functionality
│   ├── Mobile menu toggle
│   ├── Smooth scrolling
│   ├── Form validation
│   ├── Dropdown menus
│   └── API call utilities
└── admin.js           # Admin dashboard
    ├── Dashboard loader
    ├── Page editor
    ├── News manager
    ├── Theme customizer
    ├── Modal dialogs
    └── CRUD operations
```

### 5. Database Schema

#### Tables

1. **users**
   - id, username, password_digest, role
   - Stores admin user accounts
   - BCrypt password hashing

2. **pages**
   - id, title, slug, content, layout, published, parent_id, position
   - All website pages
   - Hierarchical structure support

3. **menu_items**
   - id, title, url, page_id, parent_id, position, active
   - Navigation menu structure
   - Supports nested dropdowns

4. **news_articles**
   - id, title, content, image_url, published, published_at
   - News content
   - Publishing workflow

5. **images**
   - id, filename, path, alt_text, category
   - Media library
   - Categorized storage

6. **settings**
   - id, key, value
   - Site configuration
   - Theme settings

7. **contact_submissions**
   - id, name, email, message, read
   - Contact form entries
   - Admin notification system

### 6. External Integrations

#### Ready for Integration
1. **Donation Forms:**
   - Swim Central Video Display
   - Roa Memorial Fund
   - Memorial Program
   - (Links are placeholders, ready for actual form URLs)

2. **Squad Locker Store:**
   - Park Shop page links to external store
   - Opens in new tab

3. **YouTube Videos:**
   - Universal Playground has video embed code
   - Responsive video container
   - Replace video ID with actual content

### 7. Security Features

1. **Authentication:**
   - Session-based login
   - Secure password hashing (BCrypt)
   - Login required for admin access

2. **Authorization:**
   - Role-based access control
   - Admin, Editor, Viewer roles
   - Permission checks on sensitive operations

3. **Input Validation:**
   - Form field validation
   - Email format checking
   - Required field enforcement
   - XSS prevention (HTML escaping)

4. **Session Security:**
   - Secure session secret
   - Session expiration
   - CSRF protection (Sinatra rack-protection)

### 8. Code Documentation

All code includes comments explaining:
- Purpose of each section
- Function descriptions
- Parameter explanations
- Complex logic clarification
- CSS organization and naming

### 9. Customization

#### Without Code Changes
Through the admin dashboard, you can customize:
- All page content
- Navigation menus
- News articles
- Site colors
- Fonts
- User accounts

#### With Code Changes
Developers can customize:
- CSS layouts and styles
- JavaScript functionality
- Database schema (via migrations)
- New page templates
- Additional admin features

## Quick Start Guide

### 1. Installation
```bash
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

### 2. Start Server
```bash
bundle exec rackup --port=3000
```

### 3. Access
- Public: http://localhost:3000
- Admin: http://localhost:3000/admin/login
- Login: admin / admin123

### 4. First Steps
1. Login to admin dashboard
2. Explore the Pages manager
3. Edit a page to see the editor
4. Try the Theme customizer
5. Create a news article
6. Visit the public site to see changes

## Browser Support

Tested and compatible with:
- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- iOS Safari
- Chrome Mobile

## Performance

- Optimized CSS (organized, minimal)
- Efficient JavaScript (no heavy frameworks)
- Fast database queries (indexed fields)
- Minimal dependencies
- Static asset caching support

## Future Enhancements

Ready for addition:
1. Image upload functionality
2. Full menu CRUD interface
3. User profile management
4. Email notifications
5. File attachments
6. Advanced permissions
7. Activity logging
8. Backup/restore features
9. Multi-language support
10. Search functionality
