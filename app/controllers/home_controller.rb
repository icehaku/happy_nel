class HomeController < ApplicationController
  def index
    @researches = Research.all
  end
end
