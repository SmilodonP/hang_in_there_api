class Poster < ApplicationRecord
  def self.filter_by_params(name, min_price, max_price, sort)
    posters = all

    posters = posters.where('name ILIKE ?', "%#{name}%") if name.present?

    posters = posters.where('price >= ?', min_price) if min_price.present?

    posters = posters.where('price <= ?', max_price) if max_price.present?

    posters = posters.order(created_at: (sort == "desc" ? :desc : :asc))

    posters
  end
end