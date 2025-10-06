class Page < ActiveRecord::Base
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  belongs_to :parent, class_name: 'Page', optional: true
  has_many :children, class_name: 'Page', foreign_key: 'parent_id'
  has_many :menu_items

  before_validation :generate_slug

  scope :published, -> { where(published: true) }
  scope :root_pages, -> { where(parent_id: nil) }

  private

  def generate_slug
    if slug.blank? && title.present?
      self.slug = title.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/-+$/, '').gsub(/^-+/, '')
    end
  end
end
