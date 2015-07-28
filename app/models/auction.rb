class Auction < ActiveRecord::Base
  belongs_to :status
  belongs_to :category
  validates_presence_of :name, message: "Поле обов'язкове для заповнення"
  validates_presence_of :status_id,:category_id, message: "Виконайте вибір значення"
  validates_associated :status, :category
  validates_numericality_of :cina, message: "Введіть будь-ласка ціну"
end
