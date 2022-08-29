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
    if vertical?
      @starts_in = { x: linha_index, y: coluna_index }
      @finish_in = { x: linha_index, y: coluna_index + text.size - 1 }
    else
      @starts_in = { x: coluna_index, y: linha_index }
      @finish_in = { x: coluna_index + text.size, y: linha_index }
    end
  end
end
