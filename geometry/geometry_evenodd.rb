
require_relative '../lib/svg_canvas'
include Math

# header
s = SvgCanvas.new(1200, 1200, "geometry_evenodd")
f = s.header

# main
cn = 200
3.times{|i|
  3.times{|j|
    cx = i * cn * 2 + cn
    cy = j * cn * 2 + cn
    l = rand(20..25) * 5
    rd = [18, 15, 10, 6, 4, 3].sample
    rx = (rand(3..8) * 8).to_s
    ry = (rand(3..8) * 8).to_s
    13.times{|k|
      ad = -(sqrt(k * 459) + 30)
      cl = ['fff','eee']
      f.write %(<g fill="##{cl[(k % 2)]}" fill-rule="evenodd" stroke="#666" stroke-width="0.3">\n)
      mx = (cx - cos(PI * (90 - rd) / 180) * (l + ad)).to_s
      my = (cy - sin(PI * (90 - rd) / 180) * (l + ad)).to_s
      f.write %(<path d="M #{mx}, #{my}\n)
      (180 / rd).times{|m|
        ax = (cx + cos(PI * (90 - rd - m * rd * 2) / 180) * (l + ad)).to_s
        ay = (cy - sin(PI * (90 - rd - m * rd * 2) / 180) * (l + ad)).to_s
        f.write %(A#{rx}, #{ry} #{(m * rd * 2).to_s} 1, 1 #{"%0.3f" % ax}, #{"%0.3f" % ay}\n)
      }
      f.write %(" />\n</g>\n)
    }
  }
}

# footer
s.footer
