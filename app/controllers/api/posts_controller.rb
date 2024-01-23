class Api::PostsController < ApplicationController
  def index
    if params[:q].present? && params[:q].length > 0
      posts1 = Post.search(params[:q]).order("published_at DESC").reverse
      posts2 = Post.select { |post| post[:tags].any?{|tag| params[:q].split(",").any? { |filter| filter.in?(tag.downcase) } } }
      posts = (posts1 + posts2).uniq

      count = posts.length
      items = posts.slice(params[:offset].to_i, params[:limit].to_i)
    elsif params[:filters].present? && params[:filters].length > 0
      posts = Post.select { |post| post[:tags].any?{|tag| params[:filters].split(",").any? { |filter| filter.in?(tag.downcase) } } }
      
      count = posts.length
      items = posts.slice(params[:offset].to_i, params[:limit].to_i)
    else
      items = Post.limit(params[:limit]).offset(params[:offset])
      count = Post.count
    end

    render json: { count: count, items: items }
  end
end