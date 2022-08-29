module Cmd
  module Map
    class Finalizar
      attr_accessor :map

      def initialize(map)
        @map = map
      end

      def call
        finalizar
      end

      private

      def finalizar
        map.casas.map do |colunas|
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
        alfabeto = ('a'..'z').to_a

        map.palavras.each do |palavra|
          palavra.letras.each do |letra|
            next if alfabeto.include?(letra)

            alfabeto.push letra
          end
        end

        alfabeto
      end
    end
  end
end
