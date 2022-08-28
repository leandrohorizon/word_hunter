class AlocarPalavras
  attr_accessor :largura, :altura, :palavras

  def initialize(largura, altura, palavras)
    @largura = largura
    @altura = altura
    @palavras = palavras
  end

  def call
    alocar_palavras

    finalizar
  end

  private

  def limpar
    @casas = Array.new(altura) { Array.new(largura, '.') }
  end

  def alocar_palavras
    limpar

    palavras.each do |palavra|
      next unless palavra.vertical?
      return alocar_palavras unless encaixar_aqui(palavra)
    end

    @casas = girar

    palavras.each do |palavra|
      next unless palavra.horizontal?
      return alocar_palavras unless encaixar_aqui(palavra)
    end

    true
  end

  def encaixar_aqui(palavra)
    letras = palavra.letras()

    lista_possiveis_linhas = possiveis_linhas(letras)

    return false if lista_possiveis_linhas.empty?

    linha_index = lista_possiveis_linhas.sample

    lista_possiveis_colunas = possiveis_colunas(letras, linha_index)

    return false if lista_possiveis_colunas.empty?

    coluna_index = lista_possiveis_colunas.sample

    @casas[linha_index] =
      concatenar(@casas[linha_index].dup, letras, coluna_index)

    true
  end

  def possiveis_linhas(letras)
    casasi = []

    @casas.each_with_index do |casa, index|
      contador = 0

      casa.each do |valor|
        if valor == '.' || valor == letras[contador]
          contador += 1
        else
          contador = 0
        end

        casasi.push index if contador == letras.size
      end
    end

    casasi
  end

  def possiveis_colunas(letras, num_casa)
    casasi = []
    range_possivel = largura - letras.size

    (0..range_possivel + 1).each do |index|
      contador = 0

      (index..letras.size - 1).each do |numero2|
        casa = @casas[num_casa][numero2]
        unless casa == '.' || casa == letras[contador]
          contador = 0
          next
        end

        contador += 1

        casasi << index if contador == letras.size
      end
    end

    casasi
  end

  def concatenar(linha, letras, posicao)
    j = 0

    (0..largura).each do |x|
      if x >= posicao && j <= (letras.size - 1)
        linha[x] = letras[j]
        j += 1
      end
    end

    linha
  end

  def girar
    mapa = Array.new(altura) { Array.new(largura, '.') }

    (0..@casas.size - 1).each do |x|
      (0..@casas[x].size - 1).each do |y|
        mapa[y][x] = @casas[x][y]
      end
    end

    mapa
  end

  def finalizar
    @casas.map do |colunas|
      colunas.map do |coluna|
        if coluna == '.'
          alfabeto.sample
        else
          coluna
        end
      end
    end
  end

  def alfabeto
    return @alfabeto if defined?(@alfabeto)

    @alfabeto = ('a'..'z').to_a

    palavras.each do |palavra|
      palavra.text.split('').each do |letra|
        next if @alfabeto.include?(letra)

        @alfabeto.push letra
      end
    end
  end
end

require 'pry'
require_relative '../palavra'

palavras = [
  Palavra.new('hello', :horizontal),
  Palavra.new('friend', :vertical)
]

alocate = AlocarPalavras.new(6, 6, palavras)
