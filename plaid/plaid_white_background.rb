
f = open("plaid_white_background.svg", "w") 
f.write(<<"EOS"
<?xml version="1.0" encoding="utf-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" 
 "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1"
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  width="1200" height="1200"
  viewBox="0 0 1200 1200">
<title>plaid_white_background</title>
EOS
)
int = 15
cn = [0, 90, 45, 135]
ct = ['20, 20','0, -1100','20, 10','-650,-900']
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
    f.write %(M0, #{(j * int).to_s} )
    (500 / wx).times{|k|
      wy = rand(-3..3)
      f.write %(Q#{(k * wx * 2 + wx).to_s}, #{(wy + j * int).to_s} )
      f.write %(#{(k * wx * 2 + wx * 2).to_s}, #{(j * int).to_s} )
    }
    f.write %(L1000, #{(j * int + int).to_s} )
    (500 / wx).times{|k|
      wy = rand(-3..3)
      f.write %(Q#{(1000 - (k * wx * 2 + wx)).to_s}, #{(wy + j * int + int).to_s} )
      f.write %(#{(1000 - (k * wx * 2 + wx * 2)).to_s}, #{(j * int + int).to_s} )
    }
    f.write %(L0, #{(j * int).to_s} )
    f.write %(" fill="#{(st2[j % 2])}" stroke="#{(st[j % 2])}" />\n)
  }
  f.write %(</g>\n</g>\n</g>\n</g>\n)
}
f.write %(</svg>\n)
f.close
