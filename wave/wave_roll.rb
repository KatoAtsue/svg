
f = open("wave_roll.svg", "w") 
f.write(<<"EOS"
<?xml version="1.0" encoding="utf-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
 "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1"
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  width="800" height="800"
  viewBox="0 0 800 800">
<title>wave_roll</title>
EOS
)
lx = rand(7) * 10 + 10
int = lx / 20 + 2
sw = (lx / 200.0).to_s
st = ['none', '#666']
180.times{|i|
  ang = rand(180).to_s
  cx = rand(-50..750)
  cy = rand(-50..750)
  arc = rand(lx * 2) - lx
  f.write %(<g transform="rotate(#{ang} #{(cx + lx).to_s}, #{(cy + (lx / 2)).to_s})">\n)
  27.times{|j|
		rgb = sprintf("%02x%02x%02x", rand(220..255), rand(220..255), rand(220..255))
    f.write %(<path d=")
    f.write %(M#{cx.to_s}, #{(cy + j * int).to_s} )
    f.write %(Q#{(cx + lx).to_s}, #{(cy + (j * int) - arc).to_s} )
    f.write %(#{(cx + lx * 2).to_s}, #{(cy + j * int).to_s} )
    f.write %(L#{(cx + lx * 2).to_s}, #{(cy + j * int + int).to_s} )
    f.write %(Q#{(cx + lx).to_s}, #{(cy + (j * int + int) - arc).to_s} )
    f.write %(#{cx.to_s}, #{(cy + j * int + int).to_s} )
    f.write %(L#{cx.to_s}, #{(cy + j * int).to_s})
    f.write %("\n fill="##{rgb}" stroke="#{(st[j % 2])}" stroke-width="#{sw}" opacity="0.6" />\n)
  }
  f.write %(</g>\n)
}
f.write %(</svg>\n)
f.close
