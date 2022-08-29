module Cmd
  module Map
    class Encaixar
      attr_accessor :linha, :letras, :posicao, :largura

      def initialize(linha, letras, posicao, largura)
        @linha = linha
        @letras = letras
        @posicao = posicao
        @largura = largura
      end

      def call
        encaixar
      end

      private

      def encaixar
        j = 0

        (0..largura).each do |x|
          if x >= posicao && j <= (letras.size - 1)
            linha[x] = letras[j]
            j += 1
          end
        end

        linha
      end
    end
  end
end
