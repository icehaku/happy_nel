class ResearchesController < ApplicationController
  before_action :set_research, only: [:show, :force_research_conclusion]

  def release_research
    if exist_pending_research?
      flash[:alert] = 'There is Already a Open Research.'
      redirect_to root_path
    elsif User.count < 2
      flash[:alert] = 'You need at least 2 users registered.'
      redirect_to root_path
    else
      produce_research
      flash[:success] = 'Research Started.'
      redirect_to root_path
    end
  end

  def force_research_conclusion
    User.all.each do |user|
      ResearchTokenMailer.research_concluded_email(user, @research.get_result).deliver_now
    end

    @research.finish
    flash[:warning] = 'Research Force Concluded.'
    redirect_to root_path
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
