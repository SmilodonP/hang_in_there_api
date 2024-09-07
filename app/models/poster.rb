class Poster < ApplicationRecord

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :year, presence: true, numericality: { only_integer: true }
  validates :vintage, inclusion: { in: [true, false] }
  validates :img_url, presence: true

  def self.filter_by_params(params = {})
    posters = all
    posters = posters.where('name ILIKE ?', "%#{params[:name]}%") if params[:name].present?
    posters = posters.where('price >= ?', params[:min_price]) if params[:min_price].present?
    posters = posters.where('price <= ?', params[:max_price]) if params[:max_price].present?
    posters = posters.order(created_at: (params[:sort] == "desc" ? :desc : :asc)) if params[:sort].present?
    posters
  end
end