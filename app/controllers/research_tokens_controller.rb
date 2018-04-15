class ResearchTokensController < ApplicationController
  before_action :set_research_token, only: [:cast_vote]

  def cast_vote; end

  def save_vote
    grade = params[:research_token_grade].present? ? params[:research_token_grade] : 0
    token = ResearchToken.find_by_token(params[:research_token][:token])
    token.update_attributes(grade: grade)

    redirect_to :back
  end

  private

  def set_research_token
    @research_token = ResearchToken.find_by_token(params[:token])
  end

end
