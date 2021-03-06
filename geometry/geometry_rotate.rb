
require_relative '../lib/svg_canvas'

# header
s = SvgCanvas.new(1200, 1200, "geometry_rotate")
f = s.header

# main
cn = 200
6.times{|i|
  6.times{|j|
    sc = [rand(5..10) / 10.0, rand(5..10) / 10.0].join(', ')
    ro = [rand(-2..3) * 10, rand(37..43) * 10, rand(37..43) * 10].join(', ')
    f.write %(<g transform="skewX(#{(rand(-4..4) * 10).to_s})">\n)
    f.write %(<g transform="skewY(#{(rand(-4..4) * 10).to_s})">\n)
    f.write %(<g transform="scale(#{sc})">\n)
    f.write %(<g transform="rotate(#{ro})">\n)
    x = (i + 1) * cn
    y = (j + 1) * cn
    xs = x.to_s
    ys = y.to_s
    f.write %(<circle fill="#aaa" stroke="none" cx="#{xs}" cy="#{ys}" r="1" />\n)
    18.times{|k|
      r1 = rand(k + 1) * 0.7 + 1
      r2 = rand(k + 1) * 0.7 + 1
      rd1 = (r1 * 2).to_s
      rd2 = (r2 * 2).to_s
      rh1 = (x - r1).to_s
      rh2 = (x + r1).to_s
      rs1 = r1.to_s
      rs2 = r2.to_s
      iv = y - 5 - (k * 10)
      s1 = %(circle cx="#{xs}" cy="#{iv.to_s}" r="#{rs1}" )
      s2 = %(ellipse cx="#{xs}" cy="#{iv.to_s}" rx="#{rs1}" ry="#{rs2}" )
      s3 = %(polygon points="#{xs} #{(iv - r1).to_s}, #{rh1} #{(iv + r2).to_s}, #{rh2} #{(iv + r2).to_s}" )
      s4 = %(polygon points="#{xs} #{(iv - r2).to_s}, #{rh1} #{iv.to_s}, #{xs} #{(iv + r2).to_s}, #{rh2} #{iv.to_s}" )
      s5 = %(rect x="#{rh1}" y="#{(iv - r2).to_s}" width="#{rd1}" height="#{rd2}" )
      fg = [s1, s2, s3, s4, s5].sample
      c1 = ['666', '888', 'aaa'].sample
      c2 = ['000', '333', '666'].sample
      cl1 = %(<g fill="##{c1}" fill-opacity="0.1" stroke="none">\n)
      cl2 = %(<g fill="none" stroke="##{c2}" stroke-width="0.3" stroke-opacity="0.5">\n)
      st = [cl1, cl2].sample
      f.write(st)
      n = [40, 30, 20, 18, 10, 6, 3].sample
      0.step(359, n){|l|
        f.write %(<#{fg} transform="rotate(#{l.to_s}, #{xs}, #{ys})" />\n)
      }
    f.write(%!</g>\n!)
    }
  f.write %(</g>\n</g>\n</g>\n</g>\n)
  }
}

# footer
s.footer
