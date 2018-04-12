class ResearchesController < ApplicationController
  before_action :set_research, only: [:show, :force_research_conclusion]

  def show; end

  def release_research
    if exist_pending_research?
      redirect_to root_path, notice: 'There is Already a Open Research'
    elsif User.count < 2
      redirect_to root_path, notice: 'You need at least 2 users registered.'
    else
      produce_research
      redirect_to root_path, notice: 'Research Started'
    end
  end

  def force_research_conclusion
    @research.finish
    redirect_to root_path, notice: 'Research Force Concluded.'
  end

  private

  def set_research
    @research = Research.find(params[:id])
  end

  def exist_pending_research?
    research = Research.last

    if Research.count == 0
      false
    elsif research.present? and research.concluded == true
      false
    else
      true
    end
  end

  def produce_research
    ActiveRecord::Base.transaction do
      new_research = Research.new
      new_research.save

      for i in 1..User.count
        new_research_token = ResearchToken.new(research: new_research)
        new_research_token.save
      end

      send_research_link_emails(new_research)
    end
  end

  def send_research_link_emails(research)
    research_tokens = ResearchToken.where(research: research).pluck(:token).to_ary
    User.all.each do |user|
      token = research_tokens.delete(research_tokens.sample)
      url = request.base_url+cast_vote_research_token_path(token)
      ResearchTokenMailer.research_email(user, url).deliver_now
    end
  end
end
