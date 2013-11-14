
require_relative '../lib/svg_canvas'

# header
s = SvgCanvas.new(220, 220, "ellipse_rotate")
f = s.header

# main
0.step(177,3){|i|
  f.write('<ellipse transform="rotate(' + i.to_s + ' 110, 110)" fill="none" stroke="#888"
  cx="110" cy="110" rx="30" ry="100" stroke-width="0.3" />' + "\n")
}
# footer
s.footer
