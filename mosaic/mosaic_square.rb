
require_relative '../lib/svg_canvas'

# header
s = SvgCanvas.new(1200, 1000, "mosaic_square")
f = s.header

# main
0.step(1200,10){|i|
  0.step(1000,10){|j|
    ratio = [0.85, 0.82, 0.8, 0.78, 0.75, 0.73, 0.7, 0.5, 0.3, 0].sample
    r = rand(160..220)
    g = rand(15) + r + 20
    b = rand(15) + (r * ratio).to_i
    rgb = sprintf("#%02x%02x%02x", r, g, b)
    f.write %(<rect x="#{i.to_s}" y="#{j.to_s}" fill="#{rgb}" width="9" height="9" />\n)
  }
}

# footer
s.footer
