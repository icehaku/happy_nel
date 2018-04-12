class ResearchToken < ApplicationRecord
  belongs_to :research

  after_save :send_result_if_research_concluded

  has_secure_token

  def send_result_if_research_concluded
    total_research_users = ResearchToken.where(research_id: self.research_id)
    users_already_voted = total_research_users.where.not(grade: nil)

    if total_research_users.count == users_already_voted.count
      User.all.each do |user|
        ResearchTokenMailer.research_concluded_email(user, self.research.get_result).deliver_now
      end

      self.research.finish
    end
  end
end
