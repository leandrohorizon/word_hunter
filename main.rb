require 'pry'
require './palavra'
Dir['./cmd/map/*.rb'].each { |file| require file }

palavras = [
  Palavra.new('hello', :horizontal),
  Palavra.new('friend', :vertical)
]

alocate = Cmd::Map::Construir.new(6, 6, palavras).call
binding.pry
