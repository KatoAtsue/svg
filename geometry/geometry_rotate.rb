
f = open("geometry_rotate.svg", "w")
f.write(<<"EOS"
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
  "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
  <svg version="1.1" id="ellipse"
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  width="1000" height="1000"
  overflow="visible"
  xml:space="preserve">
EOS
)
cn = 200
5.times{|i|
  5.times{|j|
    sc = [rand(5..10) / 10.0, rand(5..10) / 10.0].join(',')
    ro = [(rand(-2..3) * 10),(rand(37..43) * 10),(rand(37..43) * 10)].join(',')
    f.write('<g transform="skewX(' + ((rand(9)-4)*10).to_s + ')">' + "\n")
    f.write('<g transform="skewY(' + ((rand(9)-4)*10).to_s + ')">' + "\n")
    f.write('<g transform="scale(' + sc + ')">' + "\n")
    f.write('<g transform="rotate(' + ro + ')">' + "\n")
    x = (i + 1) * cn
    y = (j + 1) * cn
    xs = x.to_s
    ys = y.to_s
    f.write('<circle fill="#aaa" stroke="none" cx="' + xs + '" cy="' + ys + '" r="1" />' + "\n")
    18.times{|k|
      r1 = (rand(k + 1)) * 0.7 + 1
      r2 = (rand(k + 1)) * 0.7 + 1
      rd1 = r1 * 2
      rd2 = r2 * 2
      rh1 = (x - r1).to_s
      rh2 = (x + r1).to_s
      rs1 = r1.to_s
      rs2 = r2.to_s
      iv = y - 5 - (k * 10)
      s1 = 'circle cx="' + xs + '" cy="' + iv.to_s + '" r="' + rs1 + '" '
      s2 = 'ellipse cx="' + xs + '" cy="' + iv.to_s + '" rx="' + rs1 + '" ry="' + rs2 + '" '
      s3 = 'polygon points="' + xs + ' ' + (iv - r1).to_s + ',' + rh1 + ' ' + (iv + r2).to_s + ',' + rh2 + ' ' + (iv + r2).to_s + '" '
      s4 = 'polygon points="' + xs + ' ' + (iv - r2).to_s + ',' + rh1 + ' ' + iv.to_s + ',' + xs + ' ' + (iv + r2).to_s + ',' + rh2 + ' ' + iv.to_s + '" '
      s5 = 'rect x="' + rh1 + '" y="' + (iv - r2).to_s + '" width="' + rd1.to_s + '" height="' + rd2.to_s + '" '
      fg = [s1, s2, s3, s4, s5].sample
      c1 = ['666', '888', 'aaa']
      c2 = ['000', '333', '666']
      cl1 = '<g fill="#' + c1.sample + '" fill-opacity="0.1" stroke="none">'
      cl2 = '<g fill="none" stroke="#' + c2.sample + '" stroke-width="0.3" stroke-opacity="0.5">'
      st = [cl1, cl2].sample
      f.write(st)
      n = [40, 30, 20, 18, 10, 6, 3].sample
      0.step(359,n){|l|
          f.write('<' + fg + 'transform="rotate(' + l.to_s + ',' + xs + ',' + ys + ')" />' + "\n")
      }
    f.write("</g>\n")
    }
  f.write("</g>\n</g>\n</g>\n</g>\n")
  }
}
f.write("</svg>\n")
f.close
