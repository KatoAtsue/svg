
require_relative '../lib/svg_canvas'

x = 1000
y = 800

# header
s = SvgCanvas.new(x, y, "mosaic_gold")
f = s.header

# main
f.write %(<rect x="0" y="0" fill="#301000" width="#{x}" height="#{y}" />\n)
value = Array.new(6){|i| [1, 255, (6 - i) * 3, i * 0.12]}
ary = Array.new(390){|i| [(i * 0.5) ** 1.15 / 2.5, 255 - (i * 0.5) ** 1.15 / 2.5, (i * 0.5) ** 0.66 + 20, 0]}
value.concat ary

0.step(x,10){|i|
  0.step(y,6){|j|
		v = value.sample
		r = rand(v[0]) + v[1]
		g = r - v[2]
		b = r * v[3]
		rgb = sprintf("%02x%02x%02x", r, g, b)
    f.write %(<rect x="#{i.to_s}" y="#{j.to_s}" fill="##{rgb}" width="9.3" height="5.3" />\n)
  }
}

# footer
s.footer
