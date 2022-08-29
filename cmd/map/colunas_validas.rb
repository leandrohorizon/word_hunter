module Cmd
  module Map
    class ColunasValidas
      attr_accessor :casas, :palavra, :num_casa, :largura

      def initialize(casa, palavra, num_casa, largura)
        @casas = casa
        @palavra = palavra
        @num_casa = num_casa
        @largura = largura
      end

      def call
        possiveis_colunas
      end

      private

      def possiveis_colunas
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

      def letras
        @palavra.letras
      end
    end
  end
end
