class Image < ActiveRecord::Base
  validates :filename, presence: true
  validates :path, presence: true
  validates :category, inclusion: { in: %w[background top side bottom general] }, allow_nil: true
end
