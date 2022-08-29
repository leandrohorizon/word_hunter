module Cmd
  module Map
    class Construir
      attr_accessor :map

      def initialize(map)
        @map = map
      end

      def call
        construir

        Cmd::Map::Finalizar.new(map.casas, map.palavras).call
      end

      private

      def construir
        map.reset

        map.palavras.each do |palavra|
          next unless palavra.vertical?

          construir if alocar(palavra).nil?
        end

        map.casas = Cmd::Map::Girar.new(map.casas, map.largura, map.altura).call

        map.palavras.each do |palavra|
          next unless palavra.horizontal?

          construir if alocar(palavra).nil?
        end
      end

      def alocar(palavra)
        linha_index, coluna_index = posicoes_random(palavra)

        return if linha_index.nil?

        map.casas[linha_index] =
          Cmd::Map::Encaixar.new(
            map.casas[linha_index].dup, palavra.letras, coluna_index, map.largura).call
      end

      def posicoes_random(palavra)
        linhas = Cmd::Map::LinhasValidas.new(palavra, map.casas).call
        return if linhas.empty?

        linha_index = linhas.sample

        colunas = Cmd::Map::ColunasValidas.new(map.casas, palavra, linha_index, map.largura).call
        return if colunas.empty?

        coluna_index = colunas.sample

        [linha_index, coluna_index]
      end
    end
  end
end