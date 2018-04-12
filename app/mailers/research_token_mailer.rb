class ResearchTokenMailer < ApplicationMailer
  default from: 'aisse@mail.com'

  def research_email(user, url)
    @user = user
    @url = url
    mail(to: @user.email, subject: 'Happy Nel Quality Research')
  end

  def research_concluded_email(user, grade)
    @user = user
    @grade = grade
    mail(to: @user.email, subject: 'Happy Nel Quality Research Concluded')
  end
end
