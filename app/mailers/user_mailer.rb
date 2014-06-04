class UserMailer < ActionMailer::Base
  default from: "notifications@example.com"

  def delete_email(user)
    @user = user
    @url = 'http://example.com/Login'
    mail(to: @user.email, subject: 'Account Deleted')
  end

end
