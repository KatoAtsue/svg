
include Math

f = open("geometry_arc.svg", "w") 
f.write(<<"EOS"
<?xml version="1.0" encoding="utf-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" 
 "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1"
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  width="1200" height="1200"
  viewBox="0 0 1200 1200">
  <title>geometry_arc</title>
EOS
)
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
f.write %(</svg>\n)
f.close
