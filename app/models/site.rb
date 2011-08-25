class Site < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :url, :user

  def refresh_hash
    if !self.url.nil?
      new_hash  = Net::HTTP.get_response(URI.parse(self.url)).body.sum
      if self.last_hash != new_hash
        self.last_hash = new_hash
        self.save
        return true
      end
    end
    return false
  end
end
