class Poster < ApplicationRecord
  def self.sorted_by_created_at(order)
    order(created_at: (order == "desc" ? :desc : :asc))
  end
end