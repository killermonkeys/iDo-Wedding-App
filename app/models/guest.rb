class Guest < ActiveRecord::Base
  nilify_blanks :only => [:salutation, :first_name, :suffix, :additional_names, :email]
  nilify_blanks :only => [:g1_dietary_preference, :g2_dietary_preference, :g1_course1, :g2_course1, :g1_course2, :g2_course2,
                          :g1_course3, :g2_course3, :music]
  nilify_blanks :only => [:address, :gift, :rsvp]
  
  with_options :dependent => :destroy do |g|
    g.has_one :address
    g.has_one :gift
    g.has_one :rsvp
  end
  
  # accept attributes for our address, gift, and RSVP via one form
  accepts_nested_attributes_for :address, :gift, :rsvp
  
  SALUTATIONS = %w(Dr. Mr. Mrs. Miss Rev. Sir. Pastor Vicar The)

  DIETARY_MAP = [['None',0],
                 ['Vegetarian (Ovo-Lacto)',1], 
                 ['Gluten-free',2],
                 ['Other',3]]


  attr_protected :admin
  
  # Validating the guest form fields aren't empty.
  validates_presence_of :last_name
  # validates_presence_of :email
  validates_presence_of :email, :unless => lambda {|guest| guest.admin?}
  validates_associated :address, :rsvp
  
  before_create :generate_pin

  scope :admin, :conditions => { :admin => true }
  scope :non_admin, :conditions => { :admin => false }

  # for all def self.whatever methods
  class << self
    
    # perform a special find for login info
    def find_for_login(last_name, pin)
      first(:conditions => ['guests.pin = ? and guests.last_name like ?', pin, last_name])
    end
    
    # check that a given PIN isn't already in use by another record
    def pin_exists?(pin)
      all.map(&:pin).include?(pin)
    end
  end

  def name
    [first_name, last_name].compact.join(' ')
  end

  def g2_name
    [g2_first_name, g2_last_name].compact.join(' ')
  end

  def name=(names)
    first_name, last_name = names.split(' ', 2)
    if last_name.blank?
      self[:last_name] = first_name
    else
      self[:first_name], self[:last_name] = first_name, last_name
    end
  end

  def g2_full_name()
    if g2_name.blank?
      return 'their Guest'
    else
      guest_full_name = [g2_salutation, g2_name, g2_suffix].compact.join(' ').strip
      return guest_full_name
    end
  end
  
  def full_name(guest_only = false)
    guest_full_name = [salutation, name, suffix].compact.join(' ').strip
    return guest_full_name if guest_only
    if has_second_guest?
      return [guest_full_name, g2_full_name].compact.to_sentence(:two_words_connector => ' & ')
    else
      return guest_full_name
    end
  end

  def g1_full_name()
    if name.blank?
      return 'Unnamed Guest'
    else
      return full_name(guest_only=true)
    end
  end
  
  def safe_email
    return nil if email.nil?
    email.gsub('@', ' [at] ').gsub('.', ' [dot] ')
  end

  def has_menued?
    g1_course1? && ((has_second_guest? && g2_course1?) || !has_second_guest)
  end
  
  def has_rsvped?
    rsvp.present? && (!rsvp.attending.nil? || !rsvp.second_attending.nil?)
  end

  def has_rsvp?
    rsvp.present?
  end
  
  def is_attending?
    has_rsvped? && (rsvp.attending? || rsvp.second_attending?)
  end
  
  def has_address?
    address.present?
  end
  
  def has_gift?
    gift.present?
  end
  
  private
  
  # generate a PIN for this guest record
  def generate_pin
    return if read_attribute(:pin) =~ /^\d{4}$/  # don't do anything if this record already has a 4-digit PIN
    begin
      pin_value = Array.new(4) { Random.rand(0..9) }.join  # create a random 4-digit number
    end while self.class.pin_exists?(pin_value)
    write_attribute(:pin, pin_value)
  end
end
