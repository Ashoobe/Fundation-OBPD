class MenuItem < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :page, optional: true
  belongs_to :parent, class_name: 'MenuItem', optional: true
  has_many :children, class_name: 'MenuItem', foreign_key: 'parent_id'

  scope :active, -> { where(active: true) }
  scope :root_items, -> { where(parent_id: nil).order(:position) }

  def link
    url.present? ? url : (page ? "/page/#{page.slug}" : '#')
  end
end
