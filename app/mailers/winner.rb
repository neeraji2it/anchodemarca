class Winner < ActionMailer::Base
  default :from => "info@anchodemarca.org"
  
  def winner_proposal(bid)
    @bid = bid
    mail( :to       => bid.user.email,
      :subject  => "Ganador del Proyecto" )
  end

  def winner_project(bid)
    @bid = bid
    mail( :to       => bid.project.user.email,
      :subject  => "Ganador del Proyecto" )
  end
  
  def create_subscriber(user)
    @user = user
    mail(:to => "info@anchodemarca.org", :subject => "nuevo '#{user.role}' ha suscrito")
  end
  
end
