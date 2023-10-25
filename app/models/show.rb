class Show < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_doc,
                  against: %i[name]

  def self.search(query)
    Show.search_doc(query)
  end

  def title
    parts = name.split("-")
    parts[0]
  end

  def host
    parts = name.split("-")
    parts[1]
  end

  def detail
    parts = name.split("-")
    parts[2]
  end
end