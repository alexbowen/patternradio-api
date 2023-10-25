class Api::PostsController < ApplicationController
  def index
    if params[:filters].present? && params[:filters].length > 0
      posts = Post.select { |post| post[:tags].any?{|tag| params[:filters].split(",").any? { |filter| filter.in?(tag.downcase) } } }
      count = posts.length
      posts = posts.slice(params[:offset].to_i, params[:limit].to_i)
    else
      posts = Post.limit(params[:limit]).offset(params[:offset])
      count = Post.count
    end

    render json: { count: count, items: posts }
  end
end