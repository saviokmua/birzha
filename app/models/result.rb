class Result < ActiveRecord::Base
validates_presence_of :title, message: "Поле обов'язкове для заповнення"
end
