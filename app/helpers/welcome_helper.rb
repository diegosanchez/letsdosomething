module WelcomeHelper
  def slides
    [ 'slide_00', 'slide_01' ]
  end

  def most_popular_complaints( how_many = 5 )
    Complaint.top( how_many )
  end

end
