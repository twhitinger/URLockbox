module LinksHelper
  def update(link)
    link.read  ? "Unread" : "Read"
  end
  
  def format(link)
    link.read == true ? "color:yellow;" : "color:white;"
  end
end
