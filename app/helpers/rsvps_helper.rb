module RsvpsHelper
  
  def number_attending_content(rsvp, html_tag = :p, html_options = {})
    if rsvp.attending 
      html = "Yes, you will be attending."
    elsif !rsvp.attending 
      html = "No, you will not be attending."
    end
    content_tag(html_tag, html.html_safe, html_options)
  end
  
  
end
