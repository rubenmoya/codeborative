module ApplicationHelper
  def clean_url url
    url.gsub('https://', '').gsub('http://', '').gsub('www.', '')
  end
end
