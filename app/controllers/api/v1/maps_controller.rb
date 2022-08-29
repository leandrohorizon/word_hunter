class Api::V1::MapsController < ApplicationController
  def new_map
    palavras = params[:words].map do |word|
      Palavra.new(word, %i[horizontal vertical].sample)
    end

    map = Map.new(
      params[:width].to_i, params[:height].to_i, palavras
    )

    render json: Cmd::Map::Construir.new(map).call
  end

  def params_permited
    params.permit(:width, :height, words: [])
  end
end
