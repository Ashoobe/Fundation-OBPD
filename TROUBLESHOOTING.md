# Troubleshooting Guide

## Common Issues and Solutions

### Installation Issues

#### Problem: `bundle install` fails

**Symptoms:**
- Error: "Gem install failed"
- Permission errors
- Missing dependencies

**Solutions:**

1. **Check Ruby version:**
   ```bash
   ruby --version
   # Should be 3.2.1
   ```

2. **Update RubyGems:**
   ```bash
   gem update --system
   ```

3. **Install missing system dependencies:**
   ```bash
   # macOS
   brew install sqlite3
   
   # Ubuntu/Debian
   sudo apt-get install libsqlite3-dev build-essential
   ```

4. **Clear bundler cache:**
   ```bash
   bundle clean --force
   bundle install
   ```

#### Problem: Database migrations fail

**Symptoms:**
- Error: "Table already exists"
- Migration errors
- Database locked

**Solutions:**

1. **Reset database (development only):**
   ```bash
   bundle exec rake db:drop
   bundle exec rake db:create
   bundle exec rake db:migrate
   bundle exec rake db:seed
   ```

2. **Check database file permissions:**
   ```bash
   ls -la db/
   chmod 644 db/*.sqlite3
   ```

3. **Database is locked:**
   ```bash
   # Stop all running instances
   pkill -f rackup
   # Delete lock file if exists
   rm db/*.sqlite3-journal
   ```

### Server Issues

#### Problem: Server won't start

**Symptoms:**
- Port already in use
- Gem not found errors
- Configuration errors

**Solutions:**

1. **Port in use:**
   ```bash
   # Kill process on port 3000
   lsof -ti:3000 | xargs kill -9
   
   # Or use different port
   bundle exec rackup --port=3001
   ```

2. **Missing gems:**
   ```bash
   bundle install
   ```

3. **Check config.ru:**
   ```bash
   ruby -c config.ru
   ```

#### Problem: 404 errors on all routes

**Symptoms:**
- Homepage loads but other pages return 404
- Static files not loading

**Solutions:**

1. **Check public folder:**
   ```bash
   ls -la public/
   # Should have css/, js/ directories
   ```

2. **Verify routes in app.rb:**
   ```bash
   grep "get.*do" app.rb
   ```

3. **Check Sinatra configuration:**
   Look for proper `set :public_folder` in `config/environment.rb`

### Database Issues

#### Problem: "No such table" errors

**Symptoms:**
- Database queries fail
- App crashes on page load

**Solutions:**

1. **Run migrations:**
   ```bash
   bundle exec rake db:migrate
   ```

2. **Check migration status:**
   ```bash
   bundle exec rake db:migrate:status
   ```

3. **Re-seed database:**
   ```bash
   bundle exec rake db:seed
   ```

#### Problem: Database is empty (no pages/news)

**Solutions:**

1. **Re-run seeds:**
   ```bash
   bundle exec rake db:seed
   ```

2. **Check if seed file has errors:**
   ```bash
   ruby -c db/seeds.rb
   ```

3. **Manually inspect database:**
   ```bash
   sqlite3 db/development.sqlite3
   .tables
   SELECT * FROM pages;
   .quit
   ```

### Authentication Issues

#### Problem: Can't login to admin

**Symptoms:**
- "Invalid username or password"
- Login form doesn't submit
- Redirects immediately

**Solutions:**

1. **Re-create admin user:**
   ```bash
   bundle exec rake db:seed
   ```

2. **Check session configuration:**
   Verify `enable :sessions` in app.rb

3. **Clear browser cookies:**
   - Open browser DevTools
   - Application → Cookies → Clear all

4. **Verify BCrypt is installed:**
   ```bash
   bundle list | grep bcrypt
   ```

#### Problem: Logged out immediately after login

**Solutions:**

1. **Set SESSION_SECRET:**
   ```bash
   export SESSION_SECRET=$(ruby -e "require 'securerandom'; puts SecureRandom.hex(64)")
   ```

2. **Check session configuration in app.rb**

### Admin Dashboard Issues

#### Problem: Admin dashboard won't load

**Symptoms:**
- Blank page after login
- JavaScript errors in console
- Layout broken

**Solutions:**

1. **Check browser console for errors:**
   - Open DevTools (F12)
   - Look for JavaScript errors

2. **Verify JavaScript files load:**
   ```bash
   ls public/js/admin.js
   curl http://localhost:3000/js/admin.js
   ```

3. **Check admin routes:**
   ```bash
   grep "get.*admin" app.rb
   ```

#### Problem: Page editor doesn't save

**Symptoms:**
- Click "Save" but nothing happens
- No error messages
- Changes don't persist

**Solutions:**

1. **Check browser console:**
   - Look for API call errors
   - Check network tab

2. **Verify API endpoints:**
   ```bash
   curl -X POST http://localhost:3000/admin/api/pages \
     -H "Content-Type: application/json" \
     -d '{"title":"Test","slug":"test","content":"Test"}'
   ```

3. **Check user permissions:**
   - Verify current_user.can_edit? returns true

### CSS/Styling Issues

#### Problem: Styles not loading

**Symptoms:**
- Unstyled content
- Plain HTML with no formatting

**Solutions:**

1. **Check CSS files exist:**
   ```bash
   ls -la public/css/global/
   ```

2. **Verify CSS links in layout.erb:**
   ```erb
   <link rel="stylesheet" href="/css/global/reset.css">
   ```

3. **Clear browser cache:**
   - Ctrl+Shift+R (Windows/Linux)
   - Cmd+Shift+R (Mac)

4. **Check server logs for 404s**

#### Problem: Theme changes don't apply

**Solutions:**

1. **Hard reload browser:**
   - Ctrl+Shift+R

2. **Check CSS variables:**
   ```css
   :root {
     --primary-color: #2C5F2D;
     --secondary-color: #97BC62;
   }
   ```

3. **Verify settings are saved:**
   ```bash
   sqlite3 db/development.sqlite3 "SELECT * FROM settings;"
   ```

### Form Issues

#### Problem: Contact form doesn't submit

**Symptoms:**
- Form reloads page but doesn't save
- Validation errors
- No success message

**Solutions:**

1. **Check form action:**
   ```erb
   <form method="POST" action="/contact">
   ```

2. **Verify route exists:**
   ```bash
   grep "post.*contact" app.rb
   ```

3. **Check validation:**
   - All required fields filled
   - Valid email format

4. **Check database:**
   ```bash
   sqlite3 db/development.sqlite3 "SELECT * FROM contact_submissions;"
   ```

### Responsive Design Issues

#### Problem: Mobile menu doesn't work

**Solutions:**

1. **Verify JavaScript loads:**
   ```bash
   curl http://localhost:3000/js/main.js
   ```

2. **Check browser console for errors**

3. **Test menu toggle function:**
   - Open DevTools
   - Console: `document.querySelector('.menu-toggle')`

#### Problem: Layout breaks on mobile

**Solutions:**

1. **Check responsive CSS:**
   ```bash
   ls public/css/responsive/
   ```

2. **Verify media queries:**
   ```css
   @media (max-width: 768px) { ... }
   ```

3. **Test viewport meta tag:**
   ```html
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   ```

### Performance Issues

#### Problem: Slow page loads

**Solutions:**

1. **Check database size:**
   ```bash
   ls -lh db/development.sqlite3
   ```

2. **Optimize queries:**
   - Add eager loading for associations
   - Use appropriate indexes

3. **Enable caching in production**

4. **Compress assets**

### Error Messages

#### "LoadError: cannot load such file"

**Solution:**
```bash
bundle install
```

#### "NoMethodError: undefined method"

**Solutions:**
1. Check spelling in code
2. Verify method exists in model
3. Check if object is nil

#### "ActiveRecord::StatementInvalid"

**Solutions:**
1. Run migrations: `bundle exec rake db:migrate`
2. Check SQL syntax
3. Verify table exists

#### "Errno::EADDRINUSE (Address already in use)"

**Solution:**
```bash
lsof -ti:3000 | xargs kill -9
```

### Development Tools

#### View Logs

```bash
# Server output
tail -f log/development.log

# Or just watch terminal output
```

#### Debug in Browser

1. Open DevTools (F12)
2. Check:
   - Console (JavaScript errors)
   - Network (failed requests)
   - Application (cookies, storage)

#### Test Routes

```bash
# Test homepage
curl http://localhost:3000

# Test API endpoint
curl http://localhost:3000/admin/api/pages

# Test with verbose output
curl -v http://localhost:3000
```

#### Inspect Database

```bash
sqlite3 db/development.sqlite3

# List tables
.tables

# View table structure
.schema pages

# Query data
SELECT * FROM pages;
SELECT * FROM users;

# Exit
.quit
```

### Getting Help

If you're still stuck:

1. **Check documentation:**
   - README.md
   - FEATURES.md
   - QUICKSTART.md

2. **Review code comments:**
   - app.rb
   - models/*.rb
   - js/*.js

3. **Search GitHub issues:**
   - Look for similar problems
   - Create new issue with:
     - Error message
     - Steps to reproduce
     - Environment details

4. **Enable debug mode:**
   ```ruby
   # In app.rb
   set :show_exceptions, :after_handler
   ```

### Prevention Tips

1. **Regular backups:**
   ```bash
   cp db/development.sqlite3 db/backup-$(date +%Y%m%d).sqlite3
   ```

2. **Keep dependencies updated:**
   ```bash
   bundle update
   ```

3. **Test before deploying:**
   - Run all features locally
   - Test on different browsers
   - Check mobile view

4. **Use version control:**
   ```bash
   git add .
   git commit -m "Your changes"
   git push
   ```

5. **Monitor logs:**
   - Watch for errors
   - Check unusual activity

### Quick Fixes

**Everything is broken:**
```bash
# Nuclear option - reset everything
rm -rf db/*.sqlite3
bundle install
bundle exec rake db:create db:migrate db:seed
```

**Admin locked out:**
```bash
bundle exec rake db:seed
# Creates default admin/admin123
```

**Weird caching issues:**
```bash
# Clear everything
rm -rf tmp/cache/*
# Restart server
```

**JavaScript not updating:**
```bash
# Hard reload in browser
Ctrl+Shift+R (Windows/Linux)
Cmd+Shift+R (Mac)
```

## Still Need Help?

1. Check error messages carefully
2. Read the full stack trace
3. Search for specific error online
4. Review relevant documentation
5. Create detailed GitHub issue

Remember: Most issues have simple solutions - don't panic! 😊
