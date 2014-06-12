
require_relative '../lib/svg_canvas'
include Math

# header
s = SvgCanvas.new(1200, 1200, "geometry_circle")
f = s.header

# main
cn = 200
3.times{|i|
  3.times{|j|
    x = (i * cn * 2) + cn
    y = (j * cn * 2) + cn
    xs = x.to_s
    ys = y.to_s
    f.write %(<circle fill="#aaa" stroke="none" cx="#{xs}" cy="#{ys}" r="1" />\n)
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
      s1 = %(circle cx="#{xs}" cy="#{iv.to_s}" r="#{rs1}" )
      s2 = %(ellipse cx="#{xs}" cy="#{iv.to_s}" rx="#{rs1}" ry="#{rs2}" )
      s3 = %(polygon points="#{xs} #{(iv - r1).to_s},#{rh1} #{(iv + r2).to_s},#{rh2} #{(iv + r2).to_s}" )
      s4 = %(polygon points="#{xs} #{(iv - r2).to_s},#{rh1} #{iv.to_s},#{xs} #{(iv + r2).to_s},#{rh2} #{iv.to_s}" )
      s5 = %(rect x="#{rh1}" y="#{(iv - r2).to_s}" width="#{rd1.to_s}" height="#{rd2.to_s}" )
      fg = [s1, s2, s3, s4, s5].sample
      c1 = ['666', '888', 'aaa']
      c2 = ['000', '333', '666']
      cl1 = %(fill="##{c1.sample}" fill-opacity="0.1" stroke="none" )
      cl2 = %(fill="none" stroke="##{c2.sample}" stroke-width="0.3" stroke-opacity="0.5" )
      st = [cl1, cl2].sample
      n = [40, 30, 20, 18, 10, 6, 3].sample
      0.step(359,n){|l|
      f.write('<')
      f.write(fg)
      f.write(st)
      f.write %(transform="rotate(#{l.to_s},#{xs},#{ys})" />\n)
      }
    }
  }
}

# footer
s.footer
