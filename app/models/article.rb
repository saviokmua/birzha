class Article < ActiveRecord::Base
  belongs_to :auction
  validates :title, presence: true, unless: "auction_enable"
  validates :content, presence: true, unless: "auction_enable"
  validates :auction_id, presence: true, if: "auction_enable"

  def created_at_date
    self.created_at.strftime("%d.%m.%Y")
  end

  def self.block
    Article.last(3).reverse
  end

end
