module Cmd
  module Map
    class Construir
      attr_accessor :palavras, :largura, :altura

      def initialize(largura, altura, palavras)
        @palavras = palavras
        @largura = largura
        @altura = altura
      end

      def call
        construir

        Cmd::Map::Finalizar.new(@casas, @palavras).call
      end

      private

      def construir
        reset

        @palavras.each do |palavra|
          next unless palavra.vertical?

          construir if alocar(palavra).nil?
        end

        @casas = Cmd::Map::Girar.new(@casas, largura, altura).call

        @palavras.each do |palavra|
          next unless palavra.horizontal?

          construir if alocar(palavra).nil?
        end
      end

      def reset
        @casas = Array.new(altura) { Array.new(largura, '.') }
      end

      def alocar(palavra)
        linha_index, coluna_index = posicoes_random(palavra)

        return if linha_index.nil?

        @casas[linha_index] =
          Cmd::Map::Encaixar.new(
            @casas[linha_index].dup, palavra.letras, coluna_index, largura).call
      end

      def posicoes_random(palavra)
        linhas = Cmd::Map::LinhasValidas.new(palavra, @casas).call
        return if linhas.empty?

        linha_index = linhas.sample

        colunas = Cmd::Map::ColunasValidas.new(@casas, palavra, linha_index, largura).call
        return if colunas.empty?

        coluna_index = colunas.sample

        [linha_index, coluna_index]
      end
    end
  end
end
