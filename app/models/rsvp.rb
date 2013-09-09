class Rsvp < ActiveRecord::Base
  nilify_blanks :only => [:number_attending]
  
  belongs_to :guest
  
  # don't allow some Hackety McHacker to raise (or lower) the number of people they can RSVP for
  attr_protected :max_number_attending
  
  validates_presence_of :number_attending, :if => lambda{|rsvp| rsvp.attending?}
  validate :validate_number_attending_within_range
  
  with_options :include => :guest, :conditions => { :guests => { :admin => false } } do |scopes|
    scopes.scope :non_admin
    scopes.scope :yes, :conditions => { :attending => true }
    scopes.scope :no,  :conditions => { :attending => false }
    scopes.scope :undecided, :conditions => { :attending => nil }
  end
  
  ATTENDING_MAP = [[true, 'yes'], [false, 'no']]
  
  def attending_response
    ATTENDING_MAP.assoc(self[:attending]).try(:last) || self[:attending]
  end
  
  def one?
    number_attending == 1
  end
  
  def two?
    number_attending == 2
  end
  
  def max?
    number_attending == max_number_attending
  end
  
  private
  
  def validate_number_attending_within_range
    errors.add(:number_attending, "must be between 1 and #{max_number_attending}") unless number_attending.nil? || (1..max_number_attending).include?(number_attending)
  end
end
