# Deployment Guide

## Overview

This guide covers deploying the Oak Brook Park District Foundation website to production.

## Pre-Deployment Checklist

Before deploying, ensure you:

- [ ] Change default admin credentials
- [ ] Set secure environment variables
- [ ] Test all functionality locally
- [ ] Backup your database
- [ ] Review and update content
- [ ] Replace placeholder links with real URLs
- [ ] Add real images
- [ ] Test on multiple browsers
- [ ] Verify responsive design
- [ ] Update YouTube video IDs

## Environment Variables

Set these environment variables in your production environment:

```bash
SESSION_SECRET=your-secure-random-string-here
RACK_ENV=production
```

Generate a secure SESSION_SECRET:
```bash
ruby -e "require 'securerandom'; puts SecureRandom.hex(64)"
```

## Deployment Options

### Option 1: Render.com (Recommended)

Render.com provides free hosting for web apps with automatic deployment.

#### Steps:

1. **Push to GitHub**
   ```bash
   git push origin main
   ```

2. **Connect to Render**
   - Go to [render.com](https://render.com)
   - Sign up/Login with GitHub
   - Click "New +" → "Web Service"
   - Connect your repository

3. **Configure Service**
   Render will auto-detect the `render.yaml` file, which contains:
   ```yaml
   services:
     - type: web
       name: obpd-foundation
       env: ruby
       buildCommand: "./bin/render-build.sh"
       startCommand: "./bin/render-start.sh"
   ```

4. **Set Environment Variables**
   In Render dashboard:
   - Go to Environment
   - Add: `SESSION_SECRET` = (your secure random string)
   - Add: `RACK_ENV` = `production`

5. **Deploy**
   - Render will automatically build and deploy
   - Database will be created automatically
   - Seeds will run on first deployment

6. **Access Your Site**
   - Your site will be live at: `https://your-app-name.onrender.com`
   - Access admin at: `https://your-app-name.onrender.com/admin/login`

#### Auto-Deploy

Render automatically redeploys when you push to main:
```bash
git push origin main
```

### Option 2: Heroku

1. **Install Heroku CLI**
   ```bash
   brew install heroku/brew/heroku
   ```

2. **Login**
   ```bash
   heroku login
   ```

3. **Create App**
   ```bash
   heroku create your-app-name
   ```

4. **Add Buildpack**
   ```bash
   heroku buildpacks:set heroku/ruby
   ```

5. **Set Environment Variables**
   ```bash
   heroku config:set SESSION_SECRET=$(ruby -e "require 'securerandom'; puts SecureRandom.hex(64)")
   ```

6. **Deploy**
   ```bash
   git push heroku main
   ```

7. **Run Migrations**
   ```bash
   heroku run rake db:migrate
   heroku run rake db:seed
   ```

8. **Open App**
   ```bash
   heroku open
   ```

### Option 3: VPS (DigitalOcean, Linode, etc.)

For a VPS, you'll need to set up the full Ruby environment.

#### Requirements:
- Ubuntu 20.04+ or similar
- Ruby 3.2.1
- SQLite3
- Nginx (web server)
- Systemd (process manager)

#### Setup Steps:

1. **Install Ruby**
   ```bash
   sudo apt update
   sudo apt install -y build-essential libssl-dev libreadline-dev zlib1g-dev
   
   # Install rbenv
   curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-installer | bash
   
   # Install Ruby
   rbenv install 3.2.1
   rbenv global 3.2.1
   ```

2. **Install Dependencies**
   ```bash
   sudo apt install -y sqlite3 libsqlite3-dev nginx
   ```

3. **Clone Repository**
   ```bash
   git clone https://github.com/Ashoobe/Fundation-OBPD.git
   cd Fundation-OBPD
   ```

4. **Install Gems**
   ```bash
   gem install bundler
   bundle install --deployment --without development test
   ```

5. **Set Environment Variables**
   ```bash
   export SESSION_SECRET=$(ruby -e "require 'securerandom'; puts SecureRandom.hex(64)")
   export RACK_ENV=production
   ```

6. **Setup Database**
   ```bash
   bundle exec rake db:create RACK_ENV=production
   bundle exec rake db:migrate RACK_ENV=production
   bundle exec rake db:seed RACK_ENV=production
   ```

7. **Create Systemd Service**
   
   Create `/etc/systemd/system/obpd-foundation.service`:
   ```ini
   [Unit]
   Description=Oak Brook Park District Foundation
   After=network.target

   [Service]
   Type=simple
   User=www-data
   WorkingDirectory=/var/www/Fundation-OBPD
   Environment="RACK_ENV=production"
   Environment="SESSION_SECRET=your-secret-here"
   ExecStart=/usr/local/bin/bundle exec rackup -p 9292
   Restart=always

   [Install]
   WantedBy=multi-user.target
   ```

8. **Configure Nginx**
   
   Create `/etc/nginx/sites-available/obpd-foundation`:
   ```nginx
   server {
       listen 80;
       server_name your-domain.com;

       location / {
           proxy_pass http://127.0.0.1:9292;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
       }

       location /css {
           alias /var/www/Fundation-OBPD/public/css;
       }

       location /js {
           alias /var/www/Fundation-OBPD/public/js;
       }

       location /images {
           alias /var/www/Fundation-OBPD/public/images;
       }
   }
   ```

9. **Enable and Start**
   ```bash
   sudo ln -s /etc/nginx/sites-available/obpd-foundation /etc/nginx/sites-enabled/
   sudo systemctl enable obpd-foundation
   sudo systemctl start obpd-foundation
   sudo systemctl restart nginx
   ```

## Database Management

### Backup Database

**Development:**
```bash
cp db/development.sqlite3 db/backup-$(date +%Y%m%d).sqlite3
```

**Production (on server):**
```bash
cp db/production.sqlite3 /backups/db-$(date +%Y%m%d).sqlite3
```

### Restore Database

```bash
cp db/backup-20231206.sqlite3 db/production.sqlite3
bundle exec rake db:migrate
```

### Run Migrations

When you add new database changes:
```bash
bundle exec rake db:migrate RACK_ENV=production
```

## SSL/HTTPS Setup

### With Render
- Render provides free SSL certificates automatically
- Your site will be available at `https://your-app.onrender.com`

### With Heroku
- Heroku provides free SSL for `*.herokuapp.com` domains
- For custom domains, enable Heroku SSL

### With VPS + Nginx
Use Let's Encrypt (free):

```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d your-domain.com
```

## Post-Deployment

### 1. Change Admin Password

After first deployment:
1. Login to admin dashboard
2. Go to Users section
3. Change admin password
4. Save changes

### 2. Update Content

- Review all pages
- Replace placeholder images
- Update contact information
- Verify all links work
- Update donation form URLs

### 3. Configure Settings

In admin dashboard:
1. Set site title
2. Configure theme colors
3. Update footer information
4. Set meta descriptions

### 4. Test Everything

- [ ] All pages load correctly
- [ ] Navigation works
- [ ] Dropdowns function
- [ ] Contact form submits
- [ ] Admin login works
- [ ] Page editor saves
- [ ] News system works
- [ ] Theme customizer applies changes
- [ ] Responsive design on mobile
- [ ] Forms validate properly

## Monitoring

### Check Application Status

**Render:**
- View logs in Render dashboard
- Monitor deployment status

**Heroku:**
```bash
heroku logs --tail
```

**VPS:**
```bash
sudo systemctl status obpd-foundation
sudo journalctl -u obpd-foundation -f
```

### Database Status

```bash
sqlite3 db/production.sqlite3 "SELECT count(*) FROM pages;"
sqlite3 db/production.sqlite3 "SELECT count(*) FROM users;"
```

## Troubleshooting

### App Won't Start

1. Check environment variables are set
2. Verify database exists and has correct permissions
3. Check Ruby version matches Gemfile
4. Review error logs

### Database Issues

```bash
# Reset database (DANGER: deletes all data)
bundle exec rake db:reset RACK_ENV=production

# Or recreate from scratch
rm db/production.sqlite3
bundle exec rake db:create db:migrate db:seed RACK_ENV=production
```

### 500 Internal Server Error

1. Check application logs
2. Verify all migrations ran
3. Check file permissions
4. Ensure SESSION_SECRET is set

### Can't Login to Admin

1. Reset admin user:
   ```bash
   bundle exec rake db:seed RACK_ENV=production
   ```
2. This recreates the default admin user

## Performance Optimization

### Enable Caching

In production, enable rack-cache:

Add to `Gemfile`:
```ruby
gem 'rack-cache'
```

Update `config.ru`:
```ruby
use Rack::Cache
```

### Compress Assets

Install and configure `rack-contrib`:
```ruby
gem 'rack-contrib'
```

Use Gzip compression:
```ruby
use Rack::Deflater
```

### Database Optimization

Add indexes for frequently queried fields (already included in schema).

## Scaling

### Database

For larger traffic, consider:
- PostgreSQL instead of SQLite
- Connection pooling
- Database backups

### Application Servers

- Multiple Puma workers
- Use Passenger or Unicorn
- Load balancer for multiple instances

## Security Best Practices

1. **Always use HTTPS in production**
2. **Change default admin credentials immediately**
3. **Set strong SESSION_SECRET**
4. **Keep dependencies updated:**
   ```bash
   bundle update
   ```
5. **Regular database backups**
6. **Monitor for suspicious activity**
7. **Limit admin user creation**
8. **Use strong passwords**

## Support & Maintenance

### Regular Tasks

**Weekly:**
- Check error logs
- Test critical functionality
- Backup database

**Monthly:**
- Update dependencies
- Review security advisories
- Update content

**Quarterly:**
- Full security audit
- Performance review
- User feedback review

### Getting Help

- Check documentation (README, FEATURES, QUICKSTART)
- Review code comments
- Check GitHub issues
- Contact repository maintainer

## Rollback Procedure

If deployment fails:

**Render/Heroku:**
- Use dashboard to rollback to previous version

**VPS:**
```bash
git checkout previous-tag
bundle install
bundle exec rake db:migrate
sudo systemctl restart obpd-foundation
```

## Conclusion

Your Oak Brook Park District Foundation website is now deployed! 

Remember to:
- Monitor application health
- Keep backups
- Update content regularly
- Maintain security
- Test after updates

For questions or issues, refer to the project documentation or create a GitHub issue.
