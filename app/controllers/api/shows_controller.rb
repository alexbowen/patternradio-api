class Api::ShowsController < ApplicationController
  def index
    if params[:q].present? && params[:q].length > 0
      shows = Show.order("created_time DESC").search(params[:q])
    elsif params[:creator].present? && params[:creator] == "external"
      if params[:filters].present? && params[:filters].length > 0
        shows = Show.order("created_time DESC").select { |show| show[:user]["username"] != "patternradio"}.select { |show| show[:tags].any?{|tag| params[:filters].split(",").any? { |filter| filter.in?(tag["name"].downcase) } } }
      else
        shows = Show.order("created_time DESC").select { |show| show[:user]["username"] != "patternradio"}
      end
      
    elsif params[:creator].present? && params[:creator] == "internal"
      if params[:filters].present? && params[:filters].length > 0
        shows = Show.order("created_time DESC").select { |show| show[:user]["username"] == "patternradio"}.select { |show| show[:tags].any?{|tag| params[:filters].split(",").any? { |filter| filter.in?(tag["name"].downcase) } } }
      else
        shows = Show.order("created_time DESC").select { |show| show[:user]["username"] == "patternradio"}
      end
    else
      if params[:filters].present? && params[:filters].length > 0
      shows = Show.order("created_time DESC").select { |show| show[:tags].any?{|tag| params[:filters].split(",").any? { |filter| filter.in?(tag["name"].downcase) } } }
      else
        shows = Show.order("created_time DESC")
      end
    end

    # if params[:filters].present? && params[:filters].length > 0
    #   shows = shows.select { |show| show[:tags].any?{|tag| params[:filters].split(",").any? { |filter| filter.in?(tag["name"].downcase) } } }
    # end

    count = shows.length
    items = shows.slice(params[:offset].to_i, params[:limit].to_i)

    render json: { count: count, items: items }
  end
end