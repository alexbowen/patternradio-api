class Api::ShowsController < ApplicationController
  def index
    if params[:filters].present? && params[:filters].length > 0
      shows = Show.select { |show| show[:tags].any?{|tag| params[:filters].split(",").any? { |filter| filter.in?(tag["name"].downcase) } } }
      count = shows.length
      shows = shows.slice(params[:offset].to_i, params[:limit].to_i)
    else
      shows = Show.order("created_time DESC").limit(params[:limit]).offset(params[:offset]).reverse
      count = Show.count
    end

    render json: { count: count, items: shows }
  end
end