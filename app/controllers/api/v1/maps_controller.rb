class Api::V1::MapsController < ApplicationController
  def get_map
    palavras = [
      Palavra.new('hello', :horizontal),
      Palavra.new('friend', :vertical)
    ]

    map = Map.new(6, 6, palavras)
    render json: Cmd::Map::Construir.new(map).call
  end
end
