class NewsArticle < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  scope :published, -> { where(published: true).order(published_at: :desc) }

  before_create :set_published_at

  private

  def set_published_at
    self.published_at ||= Time.now if published
  end
end
