class Human < ActiveRecord::Base
  nilify_blanks :only => [:salutation, :first_name, :suffix]
  
  belongs_to :guest

  SALUTATIONS = %w(Dr. Mr. Mrs. Miss Rev. Sir. Pastor Vicar The)

end
