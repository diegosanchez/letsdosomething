module ComplaintsHelper
  def display_status_for(complaint, field)
     (complaint.errors[field] || []).join( " " ).strip
  end

  def disabled 
    return "disabled" unless user_signed_in?
    ""
  end

end
