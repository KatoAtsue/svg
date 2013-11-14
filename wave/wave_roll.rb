
require_relative '../lib/svg_canvas'

# header
s = SvgCanvas.new(800, 800, "wave_roll")
f = s.header

# main
lx = rand(7) * 10 + 10
int = lx / 20 + 2
sw = (lx / 200.0).to_s
st = ['none', '#555']
180.times{|i|
  ang = rand(180).to_s
  cx = rand(-50..750)
  cy = rand(-50..750)
  arc = rand(lx * 2) - lx
  f.write %(<g transform="rotate(#{ang} #{(cx + lx).to_s}, #{(cy + (lx / 2)).to_s})">\n)
  f.write %(<g stroke-width="#{sw}">\n)
  f.write %(<g opacity="0.7">\n)
  27.times{|j|
    cyi = cy + j * int
    rgb = sprintf("%02x%02x%02x", rand(220..255), rand(220..255), rand(220..255))
    f.write %(<path d=")
    f.write %(M#{cx.to_s}, #{cyi.to_s} )
    f.write %(Q#{(cx + lx).to_s}, #{(cyi - arc).to_s} )
    f.write %(#{(cx + lx * 2).to_s}, #{cyi.to_s} )
    f.write %(L#{(cx + lx * 2).to_s}, #{(cyi + int).to_s} )
    f.write %(Q#{(cx + lx).to_s}, #{(cyi + int - arc).to_s} )
    f.write %(#{cx.to_s}, #{(cyi + int).to_s} )
    f.write %(L#{cx.to_s}, #{cyi.to_s}" )
    f.write %(fill="##{rgb}" stroke="#{(st[j % 2])}" />\n)
  }
  f.write %(</g>\n</g>\n</g>\n)
}

# footer
s.footer
