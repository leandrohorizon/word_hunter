module Cmd
  module Map
    class DiagonaisValidas
      attr_accessor :palavra, :map

      def initialize(palavra, map)
        @palavra = palavra
        @map = map
      end

      def call
        alocar

        map
      end

      private

      def alocar
        x, y = diagonais_validas.sample

        palavra.letras.each_with_index do |letra, index|
          map.casas[x + index][y + index] = letra
        end
      end

      def diagonais_validas
        casasi = []
        largura, altura = area_possivel

        (0..largura).each do |x|
          contador = 0

          (0..altura).each do |y|
            palavra.letras.each_with_index do |_, index|
              casa = map.casas[x + index][y + index]

              if casa.nil? || casa == palavra.letras[contador]
                contador += 1
              else
                contador = 0
              end

              casasi << [x, y] if contador == palavra.letras.size
            end
          end
        end

        casasi
      end

      def area_possivel
        [@map.largura - @palavra.text.size,
         @map.altura - @palavra.text.size]
      end
    end
  end
end
