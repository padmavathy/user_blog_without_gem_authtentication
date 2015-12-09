class UserMailer < ActionMailer::Base

  def registration_confirmation(user)
    @user = user
    @message = 'Thanks for the registration, Please click the below link to complete the registration'
    mail(:from => "selvam62@gmail.com", :to => "#{ @user.to_s } <#{@user.email}>", :subject => "Thank you for registration")
  end

end