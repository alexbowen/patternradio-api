class Show < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_doc,
                  against: %i[tags name]

  def self.search(query)
    Show.search_doc(query)
  end
end