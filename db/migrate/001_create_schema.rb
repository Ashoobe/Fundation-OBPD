class CreateSchema < ActiveRecord::Migration[7.0]
  def change
    # Users table for admin authentication
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :role, default: 'editor' # admin, editor, viewer
      t.timestamps
    end
    add_index :users, :username, unique: true

    # Pages table for all website pages
    create_table :pages do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :content
      t.string :layout, default: 'default'
      t.boolean :published, default: true
      t.integer :parent_id
      t.integer :position, default: 0
      t.timestamps
    end
    add_index :pages, :slug, unique: true

    # Menu items table
    create_table :menu_items do |t|
      t.string :title, null: false
      t.string :url
      t.integer :page_id
      t.integer :parent_id
      t.integer :position, default: 0
      t.boolean :active, default: true
      t.timestamps
    end

    # News articles table
    create_table :news_articles do |t|
      t.string :title, null: false
      t.text :content
      t.string :image_url
      t.boolean :published, default: true
      t.datetime :published_at
      t.timestamps
    end

    # Images table for media management
    create_table :images do |t|
      t.string :filename, null: false
      t.string :path, null: false
      t.string :alt_text
      t.string :category # background, top, side, bottom
      t.timestamps
    end

    # Settings table for theme and configuration
    create_table :settings do |t|
      t.string :key, null: false
      t.text :value
      t.timestamps
    end
    add_index :settings, :key, unique: true

    # Contact form submissions
    create_table :contact_submissions do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.text :message, null: false
      t.boolean :read, default: false
      t.timestamps
    end
  end
end
