Rails.application.routes.draw do
  root to: "home#index"

  get "release_research", to: "researches#release_research"
  get "/research/:id", to: "researches#show", as: "show_research"
  get "/force_research_conclusion/:id", to: "researches#force_research_conclusion", as: "force_conclusion_research"

  get "/research_token/:token", to: "research_tokens#cast_vote", as: "cast_vote_research_token"
  get "/save_vote", to: "research_tokens#save_vote", as: "save_vote_research_tokens"

  resources :users
end
