class Post < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_doc,
                  against: %i[title]

  def self.search(query)
    Post.search_doc(query)
  end
end