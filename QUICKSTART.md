# Quick Start Guide

## Installation (5 minutes)

### Step 1: Install Dependencies
```bash
bundle install
```

This will install all required Ruby gems including:
- Sinatra (web framework)
- ActiveRecord (database ORM)
- BCrypt (password hashing)
- And others...

### Step 2: Set Up Database
```bash
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

This will:
- Create the SQLite database
- Run all migrations to create tables
- Seed with initial data (pages, menus, admin user)

### Step 3: Start the Server
```bash
bundle exec rackup --port=3000
```

Or use the development script:
```bash
./bin/dev
```

## Access the Website

### Public Website
Open your browser and go to:
```
http://localhost:3000
```

You should see the Oak Brook Park District Foundation homepage with:
- Navigation menu
- Hero section
- Latest news
- Impact statistics

### Admin Dashboard
To access the admin panel:
```
http://localhost:3000/admin/login
```

**Default Credentials:**
- Username: `admin`
- Password: `admin123`

⚠️ **Important:** Change these credentials in production!

## Your First Edit

### Edit a Page

1. Login to admin dashboard
2. Click "Pages" in the sidebar
3. Click "Edit" next to any page
4. Make changes in the editor
5. Click "Save Page"
6. Visit the public site to see your changes

### Create News Article

1. Click "News" in the admin sidebar
2. Click "Add News Article"
3. Enter title and content
4. Add an image URL (optional)
5. Check "Published"
6. Click "Save"

### Customize Theme

1. Click "Theme" in the admin sidebar
2. Use color pickers to change colors
3. Select a font from the dropdown
4. Click "Save Theme"
5. See changes immediately!

## Common Tasks

### Adding a New Page

1. Admin Dashboard → Pages → Add New Page
2. Enter page title (e.g., "Our Team")
3. Slug will auto-generate (e.g., "our-team")
4. Add content using the editor
5. Check "Published" to make it live
6. Save

The page will be accessible at: `http://localhost:3000/page/our-team`

### Editing Existing Content

All the pre-built pages (Oak Leaf Legacy, Universal Playground, etc.) can be edited:

1. Admin → Pages
2. Find the page in the list
3. Click "Edit"
4. Make your changes
5. Save

### Managing Users

To create additional admin users:

1. Admin → Users
2. Click "Add New User"
3. Enter username and password
4. Select role:
   - **Admin**: Full access
   - **Editor**: Can edit content
   - **Viewer**: Read-only
5. Save

## Troubleshooting

### Database Issues

If you see database errors:
```bash
bundle exec rake db:reset
```

This will drop, recreate, migrate, and reseed the database.

### Can't Login

If you can't login with admin/admin123:
```bash
bundle exec rake db:seed
```

This will recreate the default admin user.

### Port Already in Use

If port 3000 is busy:
```bash
bundle exec rackup --port=3001
```

Then access at `http://localhost:3001`

### Missing Gems

If you see "cannot load such file" errors:
```bash
bundle install
```

## File Structure Overview

```
Fundation-OBPD/
├── views/              # ERB templates (HTML)
├── models/             # Database models
├── css/                # Stylesheets
├── js/                 # JavaScript
├── db/                 # Database files
│   ├── migrate/        # Database migrations
│   └── seeds.rb        # Initial data
├── public/             # Static assets (served directly)
└── app.rb              # Main application file
```

## Next Steps

1. **Customize Content**: Edit all pages to match your needs
2. **Add Images**: Upload images through the image manager
3. **Customize Theme**: Match your brand colors and fonts
4. **Create Users**: Add additional admin accounts
5. **Update Links**: Replace placeholder donation form links with real URLs
6. **Add YouTube Video**: Update Universal Playground page with real video ID

## Tips

- **Auto-Save**: There's no auto-save, always click "Save"
- **Preview**: Open site in another tab to preview changes
- **Backup**: Regularly backup your `db/` directory
- **Images**: Store images in `public/images/`
- **Safe Mode**: Test on development before production changes

## Getting Help

- Check `README.md` for detailed documentation
- Review `FEATURES.md` for complete feature list
- Inspect database: `sqlite3 db/development.sqlite3`
- Check logs: Server output in terminal

## Deployment

### Render.com (Recommended)

1. Push code to GitHub
2. Connect to Render.com
3. It will auto-detect the `render.yaml` config
4. Set environment variables:
   - `SESSION_SECRET`: Random secure string
5. Deploy!

### Manual Deployment

1. Set environment variables
2. Run `bundle exec rake db:migrate`
3. Run `bundle exec rake db:seed` (first time only)
4. Start with `bundle exec rackup`

## Security Checklist

Before going live:
- [ ] Change default admin password
- [ ] Set secure SESSION_SECRET environment variable
- [ ] Remove default admin user info from login page
- [ ] Enable HTTPS
- [ ] Review user permissions
- [ ] Test all forms
- [ ] Backup database

## Support

For issues or questions:
- Create an issue on GitHub
- Check the documentation files
- Review the code comments

---

**You're all set!** Start customizing your Oak Brook Park District Foundation website. 🎉
