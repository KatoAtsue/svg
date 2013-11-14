
require_relative '../lib/svg_canvas'

# header
s = SvgCanvas.new(200, 600, "ellipse_scale")
f = s.header

# main
0.step(177,3){|i|
  f.write('<ellipse transform="scale(' + (1 + (i * 0.01)).to_s + ')" fill="none" stroke="#888"
  cx="40" cy="110" rx="30" ry="100" stroke-width="' + (0.3 / (1 + i * 0.01)).to_s + '" />' + "\n")
}

# footer
s.footer
