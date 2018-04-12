class ResearchTokensController < ApplicationController
  before_action :set_research_token, only: [:cast_vote]


  def cast_vote; end

  def save_vote
    raise "save_vote"
  end

  private

  def set_research_token
    @research_token = ResearchToken.where(token: params[:token]).first
  end

end
