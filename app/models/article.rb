class Article < ActiveRecord::Base
  belongs_to :auction
  validates :title, presence: true, unless: "auction_enable"
  validates :content, presence: true, unless: "auction_enable"
  validates :auction_id, presence: true, if: "auction_enable"

def started_at_date
    self.started_at.strftime("%d.%m.%Y")
  end

end
