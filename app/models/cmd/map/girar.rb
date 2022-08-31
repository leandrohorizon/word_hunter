module Cmd
  module Map
    class Girar
      attr_accessor :map

      def initialize(map)
        @map = map
      end

      def call
        girar
      end

      private

      def girar
        mapa = Array.new(map.altura) { Array.new(map.largura, nil) }

        (0..map.casas.size - 1).each do |x|
          (0..map.casas[x].size - 1).each do |y|
            mapa[y][x] = map.casas[x][y]
          end
        end

        mapa
      end
    end
  end
end
