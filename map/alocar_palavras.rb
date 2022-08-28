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
    @linha = []
    @casas = []

    (0..largura - 1).each do |x|
      (0..altura - 1).each do |y|
        @linha[y] = '.'
      end

      @casas[x] = @linha
    end
  end

  def alocar_palavras
    limpar

    palavras.each do |palavra|
      next unless palavra.vertical?
      return alocar_palavras unless encaixar_aqui(palavra)
    end

    girar

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

    @casas[linha_index] = concatenar(@casas[linha_index].dup, letras, coluna_index)

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

        if contador == letras.size
          casasi << index
          break
        end
      end
    end

    casasi
  end

  def possiveis_colunas(letras, num_casa)
    casasi = []
    range_possivel = largura - letras.size

    (0..range_possivel).each_with_index do |_numero, index|
      contador = 0

      (0..letras.size - 1).each do |numero2|
        casa = @casas[num_casa][numero2]
        next unless casa == '.' || casa == letras[contador]

        contador += 1

        casasi << index if contador == letras.size
      end
    end

    casasi
  end

  def concatenar(arr1, arr2, posicao)
    j = 0

    (0..largura).each do |x|
      if x >= posicao && j <= (arr2.size - 1)
        arr1[x] = arr2[j]
        j += 1
      end
    end

    arr1
  end

  def girar
    mapa = @casas

    (0..@casas.size - 1).each do |x|
      (0..@casas[x].size - 1).each do |y|
        mapa[y][x] = @casas[x][y]
      end
    end
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

    @alfabeto = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]

    palavras.each do |palavra|
      palavra.text.split('').each do |letra|
        next if @alfabeto.include?(letra)

        @alfabeto << letra
      end
    end
  end
end

require 'pry'
require_relative '../palavra'

palavra = Palavra.new('ola', :horizontal)
alocate = AlocarPalavras.new(10, 10, [palavra])

alocate.call
