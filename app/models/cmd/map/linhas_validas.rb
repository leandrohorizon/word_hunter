module Cmd
  module Map
    class LinhasValidas
      attr_accessor :palavra, :casas

      def initialize(palavra, casas)
        @palavra = palavra
        @casas = casas
      end

      def call
        possiveis_linhas
      end

      private

      def possiveis_linhas
        casasi = []

        @casas.each_with_index do |casa, index|
          contador = 0

          casa.each do |valor|
            if valor.nil? || valor == letras[contador]
              contador += 1
            else
              contador = 0
            end

            casasi.push index if contador == letras.size
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
