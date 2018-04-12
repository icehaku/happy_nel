class ResearchesController < ApplicationController
  before_action :set_research, only: [:show, :force_research_conclusion]

  def show; end

  def release_research
    return unless no_pending_research?
    produce_research
    redirect_to root_path, notice: 'Research Started'
  end

  def force_research_conclusion
    @research.update_attributes(concluded: true)
    redirect_to root_path, notice: 'Research Force Concluded.'
  end

  private

  def set_research
    @research = Research.find(params[:id])
  end

  def no_pending_research?
    research = Research.last
    if research.present? == false or research.concluded == false
      false
    else
      true
    end
  end

  def produce_research
    actual_users_count = User.count

    if actual_users_count > 0
      ActiveRecord::Base.transaction do
        new_research = Research.new
        new_research.save

        for i in 1..actual_users_count
          new_research_token = ResearchToken.new(research: new_research)
          new_research_token.save
        end

        send_research_link_emails(new_research)
      end
    else
      raise "sem usuarios"
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
