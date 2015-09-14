class Auction < ActiveRecord::Base
  belongs_to :status
  belongs_to :category
  has_many :articles
  validates_presence_of :name, message: "Поле обов'язкове для заповнення"
  validates_presence_of :started_at, message: "Вкажіть дату проведення аукціону"
  validates_presence_of :status_id,:category_id, message: "Виконайте вибір значення"
  validates_associated :status, :category
  validates_numericality_of :cina, message: "Введіть будь-ласка ціну"

  def filename_origin
    self.filename[(self.id.to_s+"_").length..filename.length]
  end

  def started_at_date
    self.started_at.strftime("%d.%m.%Y") if self.started_at.present?
  end

  def self.search(search)
    res=self
    search.each do |key,value|
      if value.present?
        case key
          when 'name'
            res=res.where("name ILIKE ?", "%#{value}%")
          when 'status_id'
            res=res.where("status_id = ?", "#{value}")
          when 'category_id'
            res=res.where("category_id = ?", "#{value}")
          else
            res=res.where("1=1")
          end
      end
    end
    res
  end
end
