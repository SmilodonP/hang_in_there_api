class Api::V1::PostersController < ApplicationController
	def index
		posters = Poster.filter_by_params(
			name: params[:name],
			min_price: params[:min_price],
			max_price: params[:max_price],
			sort: params[:sort]
			)
			
		render json: PosterSerializer.new(posters, meta: { count: posters.count })
	end

	def show
		poster = Poster.find(params[:id])
		render json: PosterSerializer.new(poster)
	end

	def create
		poster = Poster.create(poster_params)
		render json: PosterSerializer.new(poster), status: 201
	end

	def update
		poster = Poster.find(params[:id])
		poster.update(poster_params)

		render json: PosterSerializer.new(poster)
	end

	def destroy
    poster = Poster.find(params[:id])
    poster.destroy
  end

	private

	def poster_params
		params.require(:poster).permit(:name, :description, :price, :year, :vintage, :img_url)
	end
end