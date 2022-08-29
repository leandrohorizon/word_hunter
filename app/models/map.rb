class Map
  attr_accessor :palavras, :largura, :altura, :casas

  def initialize(largura, altura, palavras)
    @palavras = palavras
    @largura = largura
    @altura = altura

    reset
  end

  def reset
    @casas = Array.new(altura) { Array.new(largura, '.') }
  end
end
