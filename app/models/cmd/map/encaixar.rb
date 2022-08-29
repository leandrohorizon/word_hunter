module Cmd
  module Map
    class Encaixar
      attr_accessor :map, :palavra, :linha_index, :coluna_index

      def initialize(map, palavra, linha_index, coluna_index)
        @map = map
        @palavra = palavra
        @linha_index = linha_index
        @coluna_index = coluna_index
      end

      def call
        encaixar
      end

      private

      def encaixar
        linha = map.casas[linha_index].dup

        j = 0

        (0..map.largura).each do |x|
          if x >= coluna_index && j <= (letras.size - 1)
            linha[x] = letras[j]
            j += 1
          end
        end

        linha
      end

      def letras
        palavra.letras
      end
    end
  end
end
