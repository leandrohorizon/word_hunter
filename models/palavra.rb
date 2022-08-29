class Palavra
  attr_accessor :text, :orientation, :starts_in, :finish_in

  def initialize(text, orientation)
    @text = text
    @orientation = orientation
  end

  def horizontal?
    @orientation == :horizontal
  end

  def vertical?
    @orientation == :vertical
  end

  def letras
    @text.chars
  end

  def set_positions(linha_index, coluna_index)
    @finish_in =
      if vertical?
        { x: linha_index + text.size, y: coluna_index }
      else
        { x: linha_index, y: coluna_index + text.size }
      end
  end
end
