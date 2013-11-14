
require_relative '../lib/svg_canvas'

# header
s = SvgCanvas.new(1200, 1200, "plaid_white_background")
f = s.header

# main
int = 15
cn = [0, 90]
ct = ['20, 20','0, -1100']
2.times{|i|
  f.write %(<g transform="rotate(#{cn[i].to_s})">\n)
  f.write %(<g transform="translate(#{ct[i]})">\n)
  f.write %(<g stroke-width="0.3">\n)
  f.write %(<g fill-opacity="0.3">\n)
  100.times{|j|
    r, g, b = rand(76), rand(76), rand(76)
    crgb = sprintf("#%02x%02x%02x", r + 170, g + 170, b + 170)
    wrgb = sprintf("#%02x%02x%02x", r + 70, g + 70, b + 70)
    st = ['none', wrgb]
    st2 = ['none', crgb]
    f.write %(<path d=")
    wx = [250, 100, 50, 25].sample
    jy = j * int
    f.write %(M0, #{jy.to_s} )
    (500 / wx).times{|k|
      wy = rand(-3..3)
      f.write %(Q#{(k * wx * 2 + wx).to_s}, #{(wy + jy).to_s} )
      f.write %(#{(k * wx * 2 + wx * 2).to_s}, #{jy.to_s} )
    }
    f.write %(L1000, #{(jy + int).to_s} )
    (500 / wx).times{|k|
      wy = rand(-3..3)
      f.write %(Q#{(1000 - (k * wx * 2 + wx)).to_s}, #{(wy + jy + int).to_s} )
      f.write %(#{(1000 - (k * wx * 2 + wx * 2)).to_s}, #{(jy + int).to_s} )
    }
    f.write %(L0, #{jy.to_s} )
    f.write %(" fill="#{(st2[j % 2])}" stroke="#{(st[j % 2])}" />\n)
  }
  f.write %(</g>\n</g>\n</g>\n</g>\n)
}

# footer
s.footer
