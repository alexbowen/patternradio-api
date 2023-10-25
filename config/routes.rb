Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    # scope "v:api_version", api_version: /1/ do
    #   resources :jobs, only: %i[index show], controller: "vacancies"
    #   get "/location_suggestion(/:location)", to: "location_suggestion#show", as: :location_suggestion
    #   resources :markers, only: %i[show]
    # end

    resources :shows, only: %i[index]
    resources :posts, only: %i[index]

    namespace :search do
      resources :shows, only: %i[index]
      resources :posts, only: %i[index]
    end
  end
end
