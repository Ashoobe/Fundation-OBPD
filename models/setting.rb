class Setting < ActiveRecord::Base
  validates :key, presence: true, uniqueness: true

  def self.get(key, default = nil)
    setting = find_by(key: key)
    setting ? setting.value : default
  end

  def self.set(key, value)
    setting = find_or_initialize_by(key: key)
    setting.value = value.to_s
    setting.save
  end
end
