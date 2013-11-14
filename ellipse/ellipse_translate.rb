
require_relative '../lib/svg_canvas'

# header
s = SvgCanvas.new(250, 220, "ellipse_translate")
f = s.header

# main
0.step(177,3){|i|
  f.write('<ellipse transform="translate(' + i.to_s + ' 0)" fill="none" stroke="#888"
  cx="40" cy="110" rx="30" ry="100" stroke-width="0.3" />' + "\n")
}

# footer
s.footer
