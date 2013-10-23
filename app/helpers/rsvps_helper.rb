module RsvpsHelper
  
  def number_attending_content(rsvp, html_tag = :p, html_options = {})
    if rsvp.attending && rsvp.second_attending
      html = "Yes, #{rsvp.guest.name} and #{rsvp.guest.g2_name} will both be attending."
    elsif rsvp.attending && !rsvp.second_attending
      html = "Yes, #{rsvp.guest.name} will be attending."
    elsif !rsvp.attending && rsvp.second_attending
      html = "Yes, #{rsvp.guest.g2_name} will be attending."
    end
    content_tag(html_tag, html.html_safe, html_options)
  end
  
  
end
