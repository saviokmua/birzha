class Unprocessed < ActiveRecord::Base
  validates :title, presence: true

  def filename_origin
    self.filename[(self.id.to_s+"_").length..filename.length]
  end

 
end
