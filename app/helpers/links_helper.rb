module LinksHelper
  def update(link)
    link.read == true ? "Unread" : "Read"
  end
end
