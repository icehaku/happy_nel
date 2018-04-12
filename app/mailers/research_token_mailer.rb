class ResearchTokenMailer < ApplicationMailer
  default from: 'aisse@mail.com'

  def research_email(user, url)
    @user = user
    @url = url
    mail(to: @user.email, subject: 'Happy Nel Quality Research')
  end
end
