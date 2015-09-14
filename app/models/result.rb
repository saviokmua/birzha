class Result < ActiveRecord::Base
validates_presence_of :title, message: "Поле обов'язкове для заповнення"

  def date_at_date
    self.date.strftime("%d.%m.%Y") if self.date.present?
  end
end
