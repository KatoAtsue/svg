
require_relative '../lib/svg_canvas'

# header
s = SvgCanvas.new(1200, 1200, "wave_simple")
f = s.header

# main
cn = [[0, 20, 30],[45, 90, -60]]
2.times{|i|
  f.write %(<g transform="rotate(#{cn[i][0]})">\n)
  70.times{|j|
    f.write %(<path d=")
    10.times{|k|
      cx = cn[i][1] + 100 * k
      cy = cn[i][2] + j * 4
      f.write %(M#{cx.to_s}, #{cy.to_s} )
      f.write %(Q#{(cx + 25).to_s}, #{(cy - 5).to_s} )
      f.write %(#{(cx + 50).to_s}, #{cy.to_s} )
      f.write %(Q#{(cx + 75).to_s}, #{(cy + 5).to_s} )
      f.write %(#{(cx + 100).to_s}, #{cy.to_s}\n )
    }
    f.write %(" fill="none" stroke="#aaa" stroke-width="0.5" />\n)
  }
  f.write %(</g>\n)
}

# footer
s.footer
