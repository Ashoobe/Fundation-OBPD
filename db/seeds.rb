# Create default admin user
admin = User.create!(
  username: 'admin',
  password: 'admin123',
  role: 'admin'
)

puts "Created admin user (username: admin, password: admin123)"

# Create pages with pre-built content
home_page = Page.create!(
  title: 'Home',
  slug: 'home',
  content: '<h1>Welcome to Oak Brook Park District Foundation</h1><p>Supporting our community through parks and recreation.</p>',
  published: true,
  position: 1
)

# Community Impact pages
oak_leaf = Page.create!(
  title: 'Oak Leaf Legacy',
  slug: 'oak-leaf-legacy',
  content: %{
    <h1>Oak Leaf Legacy</h1>
    <p>The Oak Leaf Legacy program recognizes individuals and families who have made a lasting impact on the Oak Brook Park District through their generous support and dedication.</p>
    <p>Members of the Oak Leaf Legacy are honored for their commitment to ensuring that future generations can enjoy exceptional parks, facilities, and programs.</p>
    <h2>Benefits of Membership</h2>
    <ul>
      <li>Recognition on our donor wall</li>
      <li>Invitation to exclusive events</li>
      <li>Quarterly newsletter updates</li>
      <li>Legacy plaque for families</li>
    </ul>
    <h2>Join the Oak Leaf Legacy</h2>
    <p>To learn more about becoming a member of the Oak Leaf Legacy, please contact us or consider making a planned gift to the Foundation.</p>
  },
  published: true,
  position: 10
)

light_the_way = Page.create!(
  title: 'How We Light the Way',
  slug: 'how-we-light-the-way',
  content: %{
    <h1>How We Light the Way</h1>
    <p>The "Light the Way" initiative illuminates our parks and pathways, making them safer and more accessible for all community members to enjoy year-round.</p>
    <h2>Our Mission</h2>
    <p>Through strategic lighting improvements, we enhance the safety and usability of our park spaces, allowing families to gather and recreate safely even as daylight hours shorten.</p>
    <h2>Impact</h2>
    <ul>
      <li>Improved safety on walking paths</li>
      <li>Extended hours for park usage</li>
      <li>Enhanced security for facilities</li>
      <li>Energy-efficient LED technology</li>
    </ul>
    <h2>Support This Initiative</h2>
    <p>Your donation helps us continue to light the way for our community. Every contribution makes a difference in creating safer, more welcoming park spaces.</p>
  },
  published: true,
  position: 11
)

athlete_year = Page.create!(
  title: 'Athlete of the Year',
  slug: 'athlete-of-the-year',
  content: %{
    <h1>Athlete of the Year</h1>
    <p>The Oak Brook Park District Foundation proudly sponsors the annual Athlete of the Year award, recognizing outstanding athletic achievement, sportsmanship, and community involvement.</p>
    <h2>Award Criteria</h2>
    <ul>
      <li>Exceptional athletic performance</li>
      <li>Demonstration of good sportsmanship</li>
      <li>Leadership on and off the field</li>
      <li>Community service involvement</li>
      <li>Academic excellence</li>
    </ul>
    <h2>Nomination Process</h2>
    <p>Nominations are accepted annually from coaches, teachers, and community members. Winners receive a scholarship award and recognition at our annual banquet.</p>
    <h2>Past Recipients</h2>
    <p>Our past Athlete of the Year recipients have gone on to compete at collegiate levels and become community leaders, continuing to inspire others through their achievements.</p>
  },
  published: true,
  position: 12
)

dean_sanctuary = Page.create!(
  title: 'Dean Nature Sanctuary',
  slug: 'dean-nature-sanctuary',
  content: %{
    <h1>Dean Nature Sanctuary</h1>
    <p>The Dean Nature Sanctuary is a pristine natural area dedicated to preserving local wildlife habitats and providing environmental education opportunities for our community.</p>
    <h2>Features</h2>
    <ul>
      <li>Over 50 acres of protected woodland</li>
      <li>Native plant gardens</li>
      <li>Nature trails and observation areas</li>
      <li>Educational programming for all ages</li>
      <li>Bird watching stations</li>
    </ul>
    <h2>Educational Programs</h2>
    <p>The sanctuary offers guided nature walks, wildlife observation sessions, and environmental education programs for schools and community groups.</p>
    <h2>Conservation Efforts</h2>
    <p>Through the support of the Oak Brook Park District Foundation, we maintain and enhance this vital natural resource, ensuring its preservation for future generations.</p>
  },
  published: true,
  position: 13
)

universal_playground = Page.create!(
  title: 'Universal Playground',
  slug: 'universal-playground',
  content: %{
    <h1>Universal Playground</h1>
    <p>The Universal Playground is an inclusive play space designed to welcome children of all abilities, creating opportunities for all children to play together.</p>
    <h2>Inclusive Design</h2>
    <p>Our playground features:</p>
    <ul>
      <li>Wheelchair-accessible play structures</li>
      <li>Sensory play elements</li>
      <li>Adaptive swings and equipment</li>
      <li>Smooth, navigable pathways</li>
      <li>Quiet zones for sensory breaks</li>
    </ul>
    <h2>Video Tour</h2>
    <div class="video-container">
      <iframe width="560" height="315" src="https://www.youtube.com/embed/dQw4w9WgXcQ" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
    </div>
    <p><em>Note: Replace the video ID above with your actual Universal Playground video ID</em></p>
    <h2>Community Impact</h2>
    <p>The Universal Playground has become a gathering place where children of all abilities can play side by side, fostering inclusion and understanding from an early age.</p>
  },
  published: true,
  position: 14
)

# Ways to Give Back pages
ways_to_give = Page.create!(
  title: 'Ways to Give Back',
  slug: 'ways-to-give-back',
  content: %{
    <h1>Ways to Give Back</h1>
    <p>There are many ways to support the Oak Brook Park District Foundation and make a lasting impact on our community.</p>
    <h2>Donation Options</h2>
    <ul>
      <li>One-time donations</li>
      <li>Monthly giving programs</li>
      <li>Memorial and honor gifts</li>
      <li>Planned giving and bequests</li>
      <li>Corporate partnerships</li>
    </ul>
    <h2>Volunteer Opportunities</h2>
    <p>Your time and talents are valuable! Join us for park clean-up days, event support, and program assistance.</p>
    <h2>Get Involved</h2>
    <p>Contact us to learn more about how you can make a difference in our parks and community.</p>
  },
  published: true,
  position: 20
)

swim_central = Page.create!(
  title: 'Swim Central Video Display',
  slug: 'swim-central-video-display',
  content: %{
    <h1>Swim Central Video Display</h1>
    <p>Help us install a state-of-the-art digital video display at Swim Central to enhance the experience for swimmers, families, and spectators.</p>
    <h2>Project Goals</h2>
    <ul>
      <li>Real-time swim meet results</li>
      <li>Program schedules and updates</li>
      <li>Safety information and weather alerts</li>
      <li>Community announcements</li>
    </ul>
    <h2>Support This Project</h2>
    <div class="donation-link">
      <a href="#" class="btn-donate">Donate Now</a>
    </div>
  },
  published: true,
  position: 21
)

park_shop = Page.create!(
  title: 'Park Shop',
  slug: 'park-shop',
  content: %{
    <h1>Park Shop</h1>
    <p>Support the Oak Brook Park District Foundation while showing your park pride! Visit our online store for official merchandise.</p>
    <h2>Shop Now</h2>
    <div class="external-link">
      <a href="https://squadlocker.com" target="_blank" class="btn-shop">Visit Squad Locker Store</a>
    </div>
    <p>All proceeds from merchandise sales support Foundation programs and projects.</p>
  },
  published: true,
  position: 22
)

roa_memorial = Page.create!(
  title: 'Apparoa (Roa) Memorial Fund',
  slug: 'apparoa-roa-memorial-fund',
  content: %{
    <h1>Apparoa (Roa) Memorial Fund</h1>
    <p>The Apparoa Memorial Fund honors the memory of a beloved community member and supports youth athletic programs.</p>
    <h2>About the Fund</h2>
    <p>This fund provides scholarships and program support to ensure that all young people have access to quality athletic opportunities, regardless of financial circumstances.</p>
    <h2>Make a Donation</h2>
    <div class="donation-link">
      <a href="#" class="btn-donate">Donate to the Roa Memorial Fund</a>
    </div>
  },
  published: true,
  position: 23
)

memorial_program = Page.create!(
  title: 'Memorial Program',
  slug: 'memorial-program',
  content: %{
    <h1>Memorial Program</h1>
    <p>Honor a loved one with a lasting tribute in our parks through our Memorial Program.</p>
    <h2>Memorial Options</h2>
    <ul>
      <li><strong>Memorial Trees:</strong> Plant a tree in memory of a loved one</li>
      <li><strong>Memorial Benches:</strong> Place a personalized bench in a park location</li>
      <li><strong>Memorial Bricks:</strong> Add an engraved brick to our memorial walkway</li>
    </ul>
    <h2>Create a Memorial</h2>
    <div class="donation-link">
      <a href="#" class="btn-donate">Learn More &amp; Donate</a>
    </div>
  },
  published: true,
  position: 24
)

# Other pages
project_page = Page.create!(
  title: 'Projects',
  slug: 'projects',
  content: %{
    <h1>Foundation Projects</h1>
    <h2>Current Projects</h2>
    <ul>
      <li><strong>Swim Central Digital Video Display Screen:</strong> Modern display for swim meets and facility information</li>
      <li><strong>Memorial Trees/Benches/Bricks:</strong> Honor loved ones with lasting tributes</li>
      <li><strong>Scholarship Funding:</strong> Supporting access to programs for all community members</li>
    </ul>
    <h2>Proposed Projects</h2>
    <ul>
      <li><strong>Ball Field Re-location:</strong> Improved field positioning and drainage</li>
      <li><strong>Nature Play Area with Tree House:</strong> Natural play experiences for children</li>
      <li><strong>Tennis Center Remodel:</strong> Updated facilities and amenities</li>
      <li><strong>Meditation Garden:</strong> Peaceful space for reflection and relaxation</li>
      <li><strong>Outdoor Pickleball Courts:</strong> New courts for the growing sport</li>
      <li><strong>Open Space Preservation:</strong> Protecting green spaces for future generations</li>
    </ul>
  },
  published: true,
  position: 30
)

about_page = Page.create!(
  title: 'About',
  slug: 'about',
  content: %{
    <h1>About the Oak Brook Park District Foundation</h1>
    <p>The Oak Brook Park District Foundation is a nonprofit organization dedicated to supporting and enhancing the parks, facilities, and programs of the Oak Brook Park District.</p>
    <h2>Our Mission</h2>
    <p>To secure financial support and resources that enable the Oak Brook Park District to provide exceptional recreational opportunities and maintain beautiful, accessible parks for all community members.</p>
    <h2>What We Do</h2>
    <ul>
      <li>Fund capital improvements and facility enhancements</li>
      <li>Provide scholarships for programs</li>
      <li>Support equipment and technology upgrades</li>
      <li>Preserve and protect natural areas</li>
      <li>Create inclusive and accessible spaces</li>
    </ul>
  },
  published: true,
  position: 40
)

faq_page = Page.create!(
  title: 'FAQs',
  slug: 'faqs',
  content: %{
    <h1>Frequently Asked Questions</h1>
    <h3>What is the Oak Brook Park District Foundation?</h3>
    <p>The Foundation is a nonprofit organization that supports the Oak Brook Park District through fundraising and community engagement.</p>
    <h3>How can I donate?</h3>
    <p>You can donate online through our website, by mail, or by contacting us directly. We accept one-time gifts, recurring donations, and planned gifts.</p>
    <h3>Are donations tax-deductible?</h3>
    <p>Yes, the Oak Brook Park District Foundation is a 501(c)(3) nonprofit organization. All donations are tax-deductible to the extent allowed by law.</p>
    <h3>How are donations used?</h3>
    <p>Donations support park improvements, program scholarships, facility enhancements, and special projects that benefit the entire community.</p>
    <h3>Can I volunteer?</h3>
    <p>Absolutely! We welcome volunteers for events, park maintenance, and program support. Contact us to learn about current opportunities.</p>
  },
  published: true,
  position: 50
)

# Create menu structure
menu_home = MenuItem.create!(title: 'Home', url: '/', position: 1)
menu_news = MenuItem.create!(title: 'News', url: '/news', position: 2)

menu_community = MenuItem.create!(title: 'Community Impact', url: '#', position: 3)
MenuItem.create!(title: 'Oak Leaf Legacy', page_id: oak_leaf.id, parent_id: menu_community.id, position: 1)
MenuItem.create!(title: 'How We Light the Way', page_id: light_the_way.id, parent_id: menu_community.id, position: 2)
MenuItem.create!(title: 'Athlete of the Year', page_id: athlete_year.id, parent_id: menu_community.id, position: 3)
MenuItem.create!(title: 'Dean Nature Sanctuary', page_id: dean_sanctuary.id, parent_id: menu_community.id, position: 4)
MenuItem.create!(title: 'Universal Playground', page_id: universal_playground.id, parent_id: menu_community.id, position: 5)

menu_give = MenuItem.create!(title: 'Ways to Give Back', url: '#', position: 4)
MenuItem.create!(title: 'Ways to Give Back', page_id: ways_to_give.id, parent_id: menu_give.id, position: 1)
MenuItem.create!(title: 'Swim Central Video Display', page_id: swim_central.id, parent_id: menu_give.id, position: 2)
MenuItem.create!(title: 'Park Shop', page_id: park_shop.id, parent_id: menu_give.id, position: 3)
MenuItem.create!(title: 'Apparoa (Roa) Memorial Fund', page_id: roa_memorial.id, parent_id: menu_give.id, position: 4)
MenuItem.create!(title: 'Memorial Program', page_id: memorial_program.id, parent_id: menu_give.id, position: 5)

MenuItem.create!(title: 'Projects', page_id: project_page.id, position: 5)
MenuItem.create!(title: 'About', page_id: about_page.id, position: 6)
MenuItem.create!(title: 'FAQs', page_id: faq_page.id, position: 7)
MenuItem.create!(title: 'Contact', url: '/contact', position: 8)

# Create sample news articles
NewsArticle.create!(
  title: 'Foundation Announces New Scholarship Program',
  content: '<p>We are excited to announce a new scholarship program to help families access our recreational programs.</p>',
  image_url: '/images/scholarship.jpg',
  published: true,
  published_at: Time.now - 7.days
)

NewsArticle.create!(
  title: 'Universal Playground Grand Opening',
  content: '<p>Join us for the grand opening of our new Universal Playground, designed for children of all abilities.</p>',
  image_url: '/images/playground.jpg',
  published: true,
  published_at: Time.now - 14.days
)

NewsArticle.create!(
  title: 'Annual Fundraising Gala Success',
  content: '<p>Thank you to all who attended our annual fundraising gala. Together we raised over $50,000 for park improvements!</p>',
  image_url: '/images/gala.jpg',
  published: true,
  published_at: Time.now - 21.days
)

# Create default settings
Setting.set('site_title', 'Oak Brook Park District Foundation')
Setting.set('primary_color', '#2C5F2D')
Setting.set('secondary_color', '#97BC62')
Setting.set('font_family', 'Arial, sans-serif')
Setting.set('header_font', 'Georgia, serif')

puts "Database seeded successfully!"
puts "Pages created: #{Page.count}"
puts "Menu items created: #{MenuItem.count}"
puts "News articles created: #{NewsArticle.count}"
