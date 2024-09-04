class Api::V1::PostersController < ApplicationController
    def index
        render json: PosterSerializer.format_posters(Poster.all)
    end

    def show
        render json: PosterSerializer.format_poster(Poster.find(params[:id]))
    end

    def create
        poster = Poster.create(poster_params)
        render json: poster, status: 201
    end

    private

    def poster_params
        params.permit(:name, :description, :price, :year, :vintage, :img_url)
    end
    
end