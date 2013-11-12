
class Transparency
  def initialize
    @fill = "#fff"
    @stroke = "#fff"
  end

  def svg_data
    %(fill="#{"#%02x%02x%02x" % @fill}" stroke="#{"#%02x%02x%02x" % @stroke}" />\n)
  end

  def cellophane
    rgb = Array.new(3) {|i| rand(76)}
    @fill = Array.new(3) {|i| rgb[i] + 170}
    @stroke = Array.new(3) {|i| rgb[i] + 70}
    svg_data
  end

  def leaf
    @fill = [rand(130..190), rand(185..255), rand(100..130)]
    @stroke = [rand(20..70), rand(85..155), rand(10..40)]
    svg_data
  end

  def berry
    @fill = [rand(185..255), rand(100..130), rand(125..175)]
    @stroke = [rand(185..255), rand(100..130), rand(125..175)]
    svg_data
  end

  def lavender
    @fill = [rand(130..190), rand(100..130), rand(185..255)]
    @stroke = [rand(35..85), rand(10..40), rand(85..155)]
    svg_data
  end

  def orange
    @fill = [rand(215..255), rand(130..160), rand(65..110)]
    @stroke = [rand(95..170), rand(35..80), rand(10..30)]
    svg_data
  end

  def monotone
    rgb = rand(70)
    @fill = Array.new(3, rgb + 170)
    @stroke = Array.new(3, rgb + 10)
    svg_data
  end

end
