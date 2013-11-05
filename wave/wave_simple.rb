
f = open("wave_simple.svg", "w") 
f.write(<<"EOS"
<?xml version="1.0" encoding="utf-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
 "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1"
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  width="1200" height="1200"
  viewBox="0 0 1200 1200">
<title>wave_simple</title>
EOS
)
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
f.write %(</svg>\n)
f.close
