class AlocarPalavras
  attr_accessor :largura, :altura, :palavras

  def call
    limpar

    alocar_palavras
  end

  private

  def limpar
    @linha = []
    @casas = []

    (0..largura).each do |x|
      (0..altura).each do |y|
        @linha[y] = '.'
      end

      @casas[x] = @linha
    end
  end

  def alocar_palavras
    palavras.each do |palavra|
      next unless palavra.vertical?
      return alocar_palavras unless encaixar_aqui(palavra)
    end

    girar

    palavras.each do |palavra|
      next unless palavra.horizontal?
      return alocar_palavras unless encaixar_aqui(palavra)
    end

    finalizar
    true
  end

  def encaixar_aqui(palavra)
    letras = palavra.letras()

    lista_possiveis_linhas = possiveis_linhas(letras)

    return false if lista_possiveis_linhas.empty?

    random_number = SecureRandom.random_number(possiveis_linhas.size)
    linha_index = lista_possiveis_linhas[random_number]

    lista_possiveis_colunas = possiveis_colunas(letras, linha_index)

    return false if lista_possiveis_colunas.empty?

    random_number = SecureRandom.random_number(possiveis_colunas.size)
    coluna_index = lista_possiveis_colunas[random_number]

    @casas[linha_index] = concatenar(@casas[linha_index], letras, coluna_index)

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
          return
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

      (0..letras.size).each do |numero2|
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

    true
  end

  def girar
    mapa = []

    (0..@casas.size).each do |x|
      (0..@casas[x].size).each do |y|
        mapa[y][x] = @casas[x][y]
      end
    end
  end

  def finalizar
    (0..@casas.size).each do |x|
      (0..@casas[x].size).each do |y|
        if @casas[x][y] == '.'
          random_number = SecureRandom.random_number(alfabeto.size)
          @casas[x][y] = alfabeto[random_number]
        end
      end
    end
  end

  def alfabeto
    return @alfabeto if defined?(@alfabeto)

    @alfabeto = []

    palavras.each do |palavra|
      palavra.each do |letra|
        next if @alfabeto.include(letra)

        @alfabeto << letra
      end
    end
  end
end
