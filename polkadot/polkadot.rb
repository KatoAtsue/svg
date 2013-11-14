
require_relative '../lib/svg_canvas'
include Math

class Line
  def initialize(j)
    @j = j
    @cx = rand(1000)
    @cy = rand(1000)
    @diameter = rand(4..11)
  end

  def mv
    sx = @cx + @diameter
    sy = @cy
    str = %(M#{sx.to_s} #{sy.to_s} )

    angle = [1, 2, 3, 5, 6, 8, 9, 11]
    mx = [rand(@diameter) * 0.12 + 0.5, 0, 0, rand(@diameter) * -0.18, 0, 0, 0, 0]
    my = [0, rand(@diameter) * 0.18, 0, 0, 0, rand(@diameter) * -0.18, 0, 0]
    cb = ['C', '', '', 'S', '', 'S', '', 'S']
    margin_l = mx[0]

    angle.each_with_index{|a,i|
      str += cb[i]
      rd = PI * (a * 30) / 180
      margin_x = mx[i]
      margin_y = my[i]
      sx = "%0.3f" % (@cx + cos(rd) * @diameter + margin_x)
      if i == 7
        sx = "%0.3f" % (@cx + (2 - cos(rd)) * @diameter - margin_l)
      end
      sy = "%0.3f" % (@cy + sin(rd) * @diameter + margin_y)
      str += %(#{sx}, #{sy} )
    }
    str += %(#{(@cx + @diameter).to_s}, #{@cy.to_s}z)
  end
end


# header
s = SvgCanvas.new(1000, 1000, "polkadot")
f = s.header

# main
cn = [0, 90]
ct = ['20, 20','10, -970']
2.times{|i|
  f.write %(<g transform="rotate(#{cn[i].to_s})">\n)
  f.write %(<g transform="translate(#{ct[i]})">\n)
  f.write %(<g stroke-width="0.3">\n)
  f.write %(<g fill-opacity="0.3">\n)
  1300.times{|j|
    rgb = Array.new(3){|i| rand(76)}
    fc = Array.new(3){|i| "%02x" % (rgb[i] + 170)}.join
    wc = Array.new(3){|i| "%02x" % (rgb[i] + 70)}.join
    l = Line.new(j)
    f.write %(<path d="#{l.mv}" fill="##{fc}" stroke="##{wc}" />\n)
  }
  f.write %(</g>\n</g>\n</g>\n</g>\n)
}

# footer
s.footer
