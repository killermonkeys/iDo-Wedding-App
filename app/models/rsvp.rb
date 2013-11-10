class Rsvp < ActiveRecord::Base
  nilify_blanks :only => [:number_attending]
  
  belongs_to :guest
  
  # don't allow some Hackety McHacker to raise (or lower) the number of people they can RSVP for
  attr_protected :max_number_attending
  
  
  with_options :include => :guest, :conditions => { :guests => { :admin => false } } do |scopes|
    scopes.scope :non_admin
    scopes.scope :yes, :conditions => ["attending = ? OR second_attending = ?", true, true]
    scopes.scope :no,  :conditions => ["attending = ? AND (second_attending = ? OR second_attending IS NULL)", false, false]
    scopes.scope :undecided, :conditions => ["attending IS NULL OR second_attending IS NULL"]
  end
  
  ATTENDING_MAP = [[true, 'yes'], [false, 'no']]
  
  def max?
    1 + (rsvp.guest.has_second_guest ? 1 : 0)
  end

  def attending_count?
    (rsvp.attending ? 1 : 0) + (rsvp.second_attending ? 1 : 0)
  end

  def not_attending_count?
    (rsvp.attending ? 0 : 1) + (rsvp.second_attending ? 0 : 1)
  end
  
  def one?
    rsvp.attending ^ rsvp.second_attending
  end

  def two?
    rsvp.attending && rsvp.second_attending
  end

  def g1_full_name()
    if !guest || !guest.name || guest.name.blank?
      return 'Unnamed Guest'
    else
      return guest.full_name(guest_only=true)
    end
  end

  def g2_full_name()
    if !guest || guest.g2_name.blank?
      return 'their Guest'
    else
      guest_full_name = [guest.g2_salutation, guest.g2_name, guest.g2_suffix].compact.join(' ').strip
      return guest_full_name
    end
  end

  private
  
end
