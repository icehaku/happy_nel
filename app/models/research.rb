class Research < ApplicationRecord
  has_many :research_token

  def get_result
    grade_total = self.research_token.sum(:grade)
    return 0 unless grade_total > 0
    grade_total / self.research_token.where.not(grade: nil).count
  end

  def get_votes
    pending_votes = self.research_token.where.not(grade: nil).count.to_s
    total_votes = self.research_token.count.to_s
    pending_votes+"/"+total_votes
  end

  def finish
    self.update_attributes(concluded: true)
  end
end
