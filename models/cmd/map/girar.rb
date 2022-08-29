module Cmd
  module Map
    class Girar
      attr_accessor :casas, :largura, :altura

      def initialize(casas, largura, altura)
        @casas = casas
        @largura = largura
        @altura = altura
      end

      def call
        girar
      end

      private

      def girar
        mapa = Array.new(altura) { Array.new(largura, '.') }

        (0..@casas.size - 1).each do |x|
          (0..@casas[x].size - 1).each do |y|
            mapa[y][x] = @casas[x][y]
          end
        end

        mapa
      end
    end
  end
end
