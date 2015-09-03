class Feedback
  
  include ActiveModel::Validations
  attr_accessor :name, :email, :phone, :text

  validates_presence_of :name, :email, :phone, :text
  
  def initialize(attributes = {})
    @name  = attributes[:name]
    @email = attributes[:email]
    @phone = attributes[:phone]
    @text = attributes[:text]
  end
  
end

