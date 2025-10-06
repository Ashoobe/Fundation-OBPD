# Getting Started Checklist

Welcome to your Oak Brook Park District Foundation website! This checklist will guide you through getting your website up and running.

## ✅ Installation (10 minutes)

### Step 1: Install Ruby Gems
```bash
bundle install
```
- [ ] Run command
- [ ] Wait for gems to install
- [ ] Check for any errors

### Step 2: Create Database
```bash
bundle exec rake db:create
```
- [ ] Run command
- [ ] Database file created in db/

### Step 3: Run Migrations
```bash
bundle exec rake db:migrate
```
- [ ] Run command
- [ ] Database tables created

### Step 4: Seed Initial Data
```bash
bundle exec rake db:seed
```
- [ ] Run command
- [ ] Pages, menus, and admin user created
- [ ] Check output for success messages

### Step 5: Start Server
```bash
bundle exec rackup --port=3000
```
- [ ] Run command
- [ ] Server starts without errors
- [ ] Note the URL (http://localhost:3000)

## ✅ First Look (5 minutes)

### Explore Public Website
- [ ] Open http://localhost:3000 in browser
- [ ] Homepage loads with news section
- [ ] Click through navigation menu
- [ ] Test dropdown menus (Community Impact, Ways to Give Back)
- [ ] Visit a few pages (About, Projects, FAQs)
- [ ] Try the News page
- [ ] Test Contact form
- [ ] Check on mobile (resize browser or use DevTools)

### Access Admin Dashboard
- [ ] Go to http://localhost:3000/admin/login
- [ ] Login with: admin / admin123
- [ ] Dashboard loads successfully
- [ ] See statistics on dashboard

## ✅ Explore Admin Features (10 minutes)

### Test Pages Manager
- [ ] Click "Pages" in sidebar
- [ ] See list of all pages
- [ ] Click "Edit" on any page
- [ ] Make a small change
- [ ] Click "Save"
- [ ] Visit the page on public site to see change

### Test News Manager
- [ ] Click "News" in sidebar
- [ ] See list of news articles
- [ ] Try adding a new article (optional)

### Test Theme Customizer
- [ ] Click "Theme" in sidebar
- [ ] Change primary color
- [ ] Click "Save Theme"
- [ ] Notice color change immediately
- [ ] Visit public site to see new color

### Explore Other Sections
- [ ] Check "Menus" section
- [ ] Check "Users" section
- [ ] Check "Images" section
- [ ] Check "Settings" section

## ✅ Customize Content (30-60 minutes)

### Update Pages
For each page, go to Admin → Pages → Edit:

- [ ] Home page - Update welcome message
- [ ] About page - Add your foundation's history
- [ ] Projects - Update current and proposed projects
- [ ] FAQs - Customize questions and answers
- [ ] Contact - Verify contact information

### Community Impact Pages
- [ ] Oak Leaf Legacy - Customize program details
- [ ] How We Light the Way - Update initiative info
- [ ] Athlete of the Year - Adjust criteria
- [ ] Dean Nature Sanctuary - Add specific details
- [ ] Universal Playground - Update video ID

### Ways to Give Back Pages
- [ ] Ways to Give Back - Update donation options
- [ ] Swim Central Video Display - Add real donation link
- [ ] Park Shop - Update Squad Locker URL
- [ ] Roa Memorial Fund - Add real donation link
- [ ] Memorial Program - Add real donation link

### Update News
- [ ] Delete sample news articles (or keep for reference)
- [ ] Add your own news articles
- [ ] Add images to articles (if available)
- [ ] Publish articles

## ✅ Customize Appearance (15 minutes)

### Theme Customization
Admin → Theme:
- [ ] Set your primary color (main green)
- [ ] Set your secondary color (accent green)
- [ ] Choose font family
- [ ] Save changes

### Logo and Branding
- [ ] Add your logo to header (edit layout.erb if needed)
- [ ] Update site title in Settings
- [ ] Update footer content

## ✅ Configure Settings (10 minutes)

### Update Contact Information
In various places:
- [ ] Contact page - Update address, phone, email
- [ ] Footer - Update contact details
- [ ] About page - Add leadership info

### External Links
Replace placeholder links:
- [ ] Donation form URLs (update in pages)
- [ ] Squad Locker store URL (Park Shop page)
- [ ] YouTube video ID (Universal Playground page)
- [ ] Social media links (if you add them)

## ✅ Security Setup (5 minutes)

### Change Admin Password
- [ ] Login to admin dashboard
- [ ] Go to Users section
- [ ] Change admin password from default
- [ ] Save changes
- [ ] Test new password by logging out and back in

### Create Additional Users (Optional)
- [ ] Add editor accounts for staff
- [ ] Assign appropriate roles
- [ ] Share credentials securely

## ✅ Test Everything (15 minutes)

### Functionality Tests
- [ ] All navigation links work
- [ ] Dropdowns function correctly
- [ ] Pages load without errors
- [ ] News articles display properly
- [ ] Contact form submits successfully
- [ ] Admin login works
- [ ] Page editor saves changes
- [ ] Theme changes apply

### Responsive Tests
- [ ] Homepage on mobile
- [ ] Navigation menu on mobile
- [ ] Pages readable on tablet
- [ ] Contact form works on mobile
- [ ] Admin dashboard on tablet

### Browser Tests
- [ ] Test in Chrome
- [ ] Test in Firefox
- [ ] Test in Safari (if available)
- [ ] Test in Edge (if available)

## ✅ Prepare for Launch (30 minutes)

### Content Review
- [ ] Proofread all pages
- [ ] Check for placeholder text
- [ ] Verify all links work
- [ ] Ensure images load
- [ ] Check grammar and spelling

### Images
- [ ] Add hero/banner images
- [ ] Add images to news articles
- [ ] Add team photos (if applicable)
- [ ] Optimize image sizes
- [ ] Add alt text to images

### Final Polish
- [ ] Update meta descriptions (for SEO)
- [ ] Verify contact information
- [ ] Test all forms
- [ ] Check footer links
- [ ] Review privacy policy (if needed)

## ✅ Backup and Deploy

### Create Backup
```bash
cp db/development.sqlite3 db/backup-$(date +%Y%m%d).sqlite3
```
- [ ] Create database backup
- [ ] Store backup safely

### Deploy to Production
Choose your platform:

#### Option A: Render.com (Recommended)
- [ ] Push code to GitHub
- [ ] Connect repository to Render
- [ ] Configure environment variables
- [ ] Deploy
- [ ] Test live site

#### Option B: Other Platform
- [ ] Follow DEPLOYMENT.md guide
- [ ] Configure environment
- [ ] Deploy application
- [ ] Test live site

### Post-Deployment
- [ ] Visit live URL
- [ ] Test all functionality on production
- [ ] Change admin password (again, for production)
- [ ] Set up monitoring
- [ ] Configure backups

## ✅ Launch! 🚀

### Announce Your Website
- [ ] Share URL with team
- [ ] Post on social media
- [ ] Email stakeholders
- [ ] Add to existing materials

### Monitor Initial Launch
- [ ] Check for errors
- [ ] Monitor contact form submissions
- [ ] Review visitor feedback
- [ ] Fix any issues promptly

## 📚 Resources

If you get stuck, check these resources in order:

1. **QUICKSTART.md** - Quick reference guide
2. **README.md** - Comprehensive documentation
3. **FEATURES.md** - Feature details and how-to
4. **TROUBLESHOOTING.md** - Common problems and solutions
5. **DEPLOYMENT.md** - Deployment instructions
6. **ARCHITECTURE.md** - Technical details
7. **Code Comments** - Inline documentation

## 🎯 Quick Tips

### Daily Tasks
- Check contact form submissions
- Review new content in draft
- Monitor for errors

### Weekly Tasks
- Back up database
- Update news (if applicable)
- Check website on different devices
- Review analytics (if set up)

### Monthly Tasks
- Update Ruby gems (`bundle update`)
- Review and update content
- Check for security updates
- Test all functionality

## ✨ You're All Set!

Your Oak Brook Park District Foundation website is ready to go!

### What You Have:
- ✅ Professional website
- ✅ Full CMS dashboard
- ✅ 14 pages with content
- ✅ Responsive design
- ✅ Security features
- ✅ Documentation

### What You Can Do:
- ✅ Manage all content
- ✅ Publish news
- ✅ Customize appearance
- ✅ Control user access
- ✅ Handle contact forms
- ✅ Everything without code!

## 🆘 Need Help?

- **Technical Issues:** See TROUBLESHOOTING.md
- **How-To Questions:** See FEATURES.md
- **Deployment Help:** See DEPLOYMENT.md
- **General Questions:** See README.md

## 📧 Support

For additional help:
1. Check documentation files
2. Review code comments
3. Search GitHub issues
4. Create new issue with details

---

**Congratulations on your new website!** 🎉

Start customizing and make it your own!
