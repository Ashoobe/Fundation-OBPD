# Oak Brook Park District Foundation Website

A modern, fully-featured website with an integrated Content Management System (CMS) dashboard for the Oak Brook Park District Foundation.

## Features

### Public Website
- **Modern Responsive Design**: Fully responsive for desktop, tablet, and mobile devices
- **Navigation Menu**: Hierarchical menu with dropdowns for Community Impact and Ways to Give Back
- **Pre-built Pages**: All required pages with content including:
  - Oak Leaf Legacy
  - How We Light the Way
  - Athlete of the Year
  - Dean Nature Sanctuary
  - Universal Playground
  - Ways to Give Back
  - Swim Central Video Display
  - Park Shop
  - Apparoa (Roa) Memorial Fund
  - Memorial Program
  - Projects
  - About
  - FAQs
- **News System**: Dynamic news articles with images
- **Contact Form**: Functional contact form with email validation

### Admin Dashboard
- **Full CMS Control**: Manage all website content without touching code
- **Page Management**: Create, edit, delete, and publish pages
- **WYSIWYG Editor**: Rich text editor for content formatting
- **News Management**: Create and publish news articles
- **Theme Customizer**: Customize colors and fonts
- **User Management**: Control admin access levels
- **Image Manager**: Upload and manage images
- **Menu Management**: Configure site navigation
- **Settings**: Site-wide configuration options

## Project Structure

```
Fundation-OBPD/
├── css/
│   ├── global/          # Site-wide styles
│   │   ├── reset.css    # CSS reset
│   │   ├── variables.css # CSS custom properties
│   │   ├── layout.css   # Layout and structure
│   │   └── components.css # Reusable components
│   ├── pages/           # Page-specific styles
│   │   ├── home.css
│   │   ├── news.css
│   │   ├── contact.css
│   │   └── admin.css
│   └── responsive/      # Responsive breakpoints
│       ├── mobile.css
│       └── tablet.css
├── js/
│   ├── main.js          # Frontend JavaScript
│   └── admin.js         # Admin dashboard JavaScript
├── views/               # ERB templates
│   ├── layout.erb       # Main layout
│   ├── admin_layout.erb # Admin layout
│   ├── index.erb        # Home page
│   ├── page.erb         # Generic page template
│   ├── news.erb         # News listing
│   ├── news_article.erb # News article detail
│   ├── contact.erb      # Contact form
│   ├── admin_login.erb  # Admin login
│   └── admin_dashboard.erb # Admin dashboard
├── models/              # ActiveRecord models
│   ├── user.rb
│   ├── page.rb
│   ├── menu_item.rb
│   ├── news_article.rb
│   ├── image.rb
│   ├── setting.rb
│   └── contact_submission.rb
├── db/
│   ├── migrate/         # Database migrations
│   └── seeds.rb         # Initial data
├── images/              # Image assets
├── fonts/               # Font files
├── pages/               # Additional page assets
└── admin/               # Admin-specific assets

```

## Installation & Setup

### Prerequisites
- Ruby 3.2.1 or higher
- Bundler
- SQLite3

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/Ashoobe/Fundation-OBPD.git
   cd Fundation-OBPD
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Set up the database**
   ```bash
   rake db:create
   rake db:migrate
   rake db:seed
   ```

4. **Start the server**
   ```bash
   bundle exec rackup --port=3000
   ```

5. **Access the website**
   - Public site: http://localhost:3000
   - Admin dashboard: http://localhost:3000/admin/login
   - Default admin credentials: `admin` / `admin123`

## Usage

### Managing Content

1. **Login to Admin Dashboard**
   - Navigate to `/admin/login`
   - Use credentials: username `admin`, password `admin123`

2. **Create/Edit Pages**
   - Click "Pages" in the admin sidebar
   - Click "Add New Page" to create a page
   - Use the WYSIWYG editor to format content
   - Set page slug for URL
   - Toggle "Published" to make page live

3. **Manage News**
   - Click "News" in the admin sidebar
   - Create news articles with images
   - Publish or save as draft

4. **Customize Theme**
   - Click "Theme" in the admin sidebar
   - Change colors using color pickers
   - Select fonts from dropdown
   - Click "Save Theme" to apply changes

5. **View Contact Submissions**
   - Click "Settings" in the admin sidebar
   - View messages submitted via contact form

### Customizing Styles

All CSS is organized in the `/css` directory:

- **Global styles**: `/css/global/` - Edit these for site-wide changes
- **Page-specific styles**: `/css/pages/` - Edit for individual page styling
- **Responsive styles**: `/css/responsive/` - Edit for mobile/tablet layouts
- **CSS Variables**: `/css/global/variables.css` - Change theme colors, fonts, spacing

### Adding Custom JavaScript

- Public site: Add to `/js/main.js`
- Admin dashboard: Add to `/js/admin.js`

## Database Schema

The application uses SQLite with the following tables:

- **users**: Admin user accounts with role-based permissions
- **pages**: Website pages with content
- **menu_items**: Navigation menu structure
- **news_articles**: News content with publishing options
- **images**: Media library
- **settings**: Site configuration (theme, colors, fonts)
- **contact_submissions**: Contact form submissions

## Security

- Passwords are hashed using BCrypt
- Session-based authentication
- Role-based access control (admin, editor, viewer)
- CSRF protection enabled
- Input validation on all forms

## Deployment

### Render.com (Recommended)

The project includes `render.yaml` configuration:

1. Push code to GitHub
2. Connect repository to Render
3. Render will automatically detect and deploy using the configuration

### Other Platforms

For deployment to other platforms:

1. Set environment variable `SESSION_SECRET` to a secure random string
2. Run migrations: `rake db:migrate`
3. Run seeds: `rake db:seed`
4. Start with: `bundle exec rackup`

## Development

### Running Tests
```bash
bundle exec rspec
```

### Database Commands
```bash
# Create database
rake db:create

# Run migrations
rake db:migrate

# Seed database with initial data
rake db:seed

# Reset database (drop, create, migrate, seed)
rake db:reset
```

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

Copyright © 2024 Oak Brook Park District Foundation. All rights reserved.

## Support

For questions or issues, please contact:
- Email: info@obpdfoundation.org
- Phone: (630) 555-1234

## Changelog

### Version 1.0.0 (Initial Release)
- Complete website with responsive design
- Full CMS dashboard
- Page management system
- News system
- Contact form
- Theme customization
- User management
- Pre-built content for all required pages
