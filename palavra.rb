class Palavra
  attr_accessor :text, :orientation

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
    @text.split('')
  end
end
