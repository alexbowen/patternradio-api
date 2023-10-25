class Api::Search::PostsController < ApplicationController
  def index
    if params[:q].length > 0
      posts1 = Post.search(params[:q]).order("published_at DESC").reverse
      posts2 = Post.select { |post| post[:tags].any?{|tag| params[:q].split(",").any? { |filter| filter.in?(tag.downcase) } } }
      # posts2 = Post.select { |post| post[:tags].any?{|tag| tag.downcase.include? params[:q] } }

      posts = (posts1 + posts2).uniq

      count = posts.length
      posts = posts.slice(params[:offset].to_i, params[:limit].to_i)
    else
      posts = Post.all
      count = posts.length
    end

    render json: { count: count, items: posts }
  end
end