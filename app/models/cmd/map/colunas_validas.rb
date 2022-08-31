module Cmd
  module Map
    class ColunasValidas
      attr_accessor :map, :palavra, :linha_index

      def initialize(map, palavra, linha_index)
        @map = map
        @palavra = palavra
        @linha_index = linha_index
      end

      def call
        possiveis_colunas
      end

      private

      def possiveis_colunas
        casasi = []
        range_possivel = map.largura - letras.size

        (0..range_possivel + 1).each do |index|
          contador = 0

          (index..letras.size - 1).each do |coluna_index|
            casa = map.casas[linha_index][coluna_index]
            unless casa.nil? || casa == letras[contador]
              contador = 0
              next
            end

            contador += 1

            casasi << index if contador == letras.size
          end
        end

        casasi
      end

      def letras
        @palavra.letras
      end
    end
  end
end
