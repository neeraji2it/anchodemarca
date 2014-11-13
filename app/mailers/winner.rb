class Winner < ActionMailer::Base
  default :from => "from@example.com"

  def winner_proposal(bid)
    @bid = bid
    mail( :to       => bid.user.email,
      :subject  => "Winner of Project" )
  end

  def winner_project(bid)
    @bid = bid
    mail( :to       => bid.project.user.email,
      :subject  => "Winner of Project" )
  end
  
  def create_subscriber(user)
    @user = user
    mail(:to => "info@anchodemarca.org", :subject => "New '#{user.role}' has subscribed")
  end
  
end
