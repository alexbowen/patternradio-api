class Api::ShowsController < ApplicationController
  def index
    if params[:q].present? && params[:q].length > 0
      shows = Show.order("created_time DESC").search(params[:q])
      count = shows.length
      items = shows.slice(params[:offset].to_i, params[:limit].to_i).reverse
    elsif params[:filters].present? && params[:filters].length > 0
      shows = Show.order("created_time DESC").select { |show| show[:tags].any?{|tag| params[:filters].split(",").any? { |filter| filter.in?(tag["name"].downcase) } } }
      count = shows.length
      items = shows.slice(params[:offset].to_i, params[:limit].to_i).reverse
    else
      items = Show.order("created_time DESC").limit(params[:limit]).offset(params[:offset]).reverse
      count = Show.count
    end

    render json: { count: count, items: items }
  end
end