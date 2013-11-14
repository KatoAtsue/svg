
require_relative '../lib/svg_canvas'
include Math

# header
s = SvgCanvas.new(1200, 1200, "geometry_arc")
f = s.header

# main
cn = 200
3.times{|i|
  3.times{|j|
    f.write %(<g fill="none" stroke="#777" stroke-width="0.3">\n)
    cx = (i * 2 + 1) * cn
    cy = (j * 2 + 1) * cn
    l = rand(1..6)
    rd = [20, 18, 15, 4, 3, 2].sample
    rx = (rand(2..6) * 8).to_s
    ry = (rand(5..7) * 8).to_s
    mx = (cx - cos(PI * (90 - rd) / 180) * l).to_s
    my = (cy - sin(PI * (90 - rd) / 180) * l).to_s
    f.write %(<path d="M #{mx}, #{my}\n)
    230.times{|m|
      ax = (cx + cos(PI * (90 - rd - m * rd * 2) / 180) * (l + ((m * 0.05) ** 2))).to_s
      ay = (cy - sin(PI * (90 - rd - m * rd * 2) / 180) * (l + ((m * 0.05) ** 2))).to_s
      f.write %(A#{rx}, #{ry} #{(m * rd * 2).to_s} 1,1 #{ax}, #{ay}\n)
    }
    f.write %(" />\n</g>\n)
  }
}

# footer
s.footer
