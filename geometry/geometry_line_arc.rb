
include Math

f = open("geometry_line_arc.svg", "w") 
f.write(<<"EOS"
<?xml version="1.0" encoding="utf-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" 
 "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
  <svg version="1.1"
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  width="1200" height="1200"
  viewBox="0 0 1200 1200">
  <title>geometry_line_arc</title>
EOS
)
cn = 200
3.times{|i|
  3.times{|j|
    10.times{|k|
      ds = ['stroke-dasharray="2" ',' '].sample
      f.write(%!<g fill="none" stroke="#aaa" stroke-width="0.3" #{ds}>\n!)
      cx = (i * 2 + 1) * cn
      cy = (j * 2 + 1) * cn
      cs = rand(5)
      l1 = rand(1..6) * 10
      l2 = rand(10..18) * 10
      l3 = rand(5..10) * 10
      rd = [30, 20, 18, 15, 10, 6, 4, 2].sample
      rx = (rand(1..6) * 10).to_s
      ry = (rand(1..6) * 10).to_s
      co = [
        [[rd, l1]],
        [[rd, l1]],
        [[0, l3],[rd, l1]],
        [[rd/2, l3], [0, l2], [-rd/2, l3], [rd, l1]],
        [[rd/2, l3], [rd/2, l2], [-rd/2, l2], [-rd/2, l3], [rd, l1]]
      ]
      mx = (cx - cos(PI * (90 - rd) / 180) * l1).to_s
      my = (cy - sin(PI * (90 - rd) / 180) * l1).to_s
      f.write %(<path d="M #{mx}, #{my}\n)
      (180 / rd).times{|m|
        co[cs].each {|n|
          ax = (cx + cos(PI * (90 - n[0] - m * rd * 2) / 180) * n[1]).to_s
          ay = (cy - sin(PI * (90 - n[0] - m * rd * 2) / 180) * n[1]).to_s
          if cs == 0
            f.write %(A#{rx}, #{ry} #{(m * rd * 2).to_s} 1, 1 #{ax}, #{ay}\n)
          else
            f.write %(L#{ax}, #{ay}\n)
          end
        }
      }
      f.write %(" />\n</g>\n)
    }
  }
}
f.write %(</svg>\n)
f.close
