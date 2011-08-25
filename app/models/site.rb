class Site < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :url, :user
  validates_format_of :url, :with => URI::regexp
  before_save :initialize_hash!

  def refresh_hash!
    if !self.url.nil?
      new_hash  = fetch_hash(self.url)
      if self.last_hash != new_hash
        self.last_hash = new_hash
        self.save
        send_notification_email
        return true
      end
    end
    return false
  end

  private

  def initialize_hash!
    if self.url_changed?
      self.refresh_hash!
    end
  end

  def fetch_hash(url)
    Net::HTTP.get_response(URI.parse(url)).body.sum
  end

  def send_notification_email
    Notifier.site_updated(self).deliver
  end
end
