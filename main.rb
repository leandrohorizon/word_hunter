require 'pry'
require './models/map'
require './models/palavra'
Dir['./models/cmd/map/*.rb'].each { |file| require file }

palavras = [
  Palavra.new('hello', :horizontal),
  Palavra.new('friend', :vertical)
]

map = Map.new(6, 6, palavras)
alocate = Cmd::Map::Construir.new(map).call
binding.pry
