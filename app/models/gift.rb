class Gift < ActiveRecord::Base
  nilify_blanks :only => [:gift, :description]
  
  belongs_to :guest
  has_one :thank_you, :dependent => :destroy
end
