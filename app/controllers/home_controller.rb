class HomeController < ApplicationController
  def index
    @researches = Research.all.order('created_at desc')
  end
end
