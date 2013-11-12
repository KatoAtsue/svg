
require './canvas.rb'
require './transparency.rb'
include Math

class Line
  def initialize(j)
    @j = j
    @cx = rand(1000)
    @cy = rand(1000)
    @diameter = rand(4..11)
    @radian = [15, 30, 60].sample
  end

  def bz
    n = 0
    case @radian
      when 15 then n = 0.08
      when 30 then n = 0.18
      else n = 0.75
    end
    rand(@diameter) * n
  end

  def draw
    sx = @cx + @diameter
    sy = @cy
    str = %(M#{sx.to_s} #{sy.to_s} )
    angle = [1, 2, 3, 5, 6, 8, 9, 11, 12, 14, 15, 17, 18, 20, 21, 23]
    cb = ['C', '', '', 'S', '', 'S', '', 'S', '', 'S', '', 'S', '', 'S', '', 'S']
    case @radian
    when 15
      mx = [bz, bz, 0, 0, 0, 0, 0, -bz, 0, -bz, 0, 0, 0, 0, 0, bz]
      my = [0, 0, 0, bz, 0, bz, 0, 0, 0, 0, 0, -bz, 0, -bz, 0, 0]
    when 30
      angle.slice!(8, 8)
      mx = [bz, 0, 0, -bz, 0, 0, 0, 0]
      my = [0, bz, 0, 0, 0, -bz, 0, 0]
    else
      angle.slice!(4, 12)
      mx = [bz, -bz, 0, 0]
      my = [bz, bz, 0, 0]
    end
    angle.each_with_index{|a,i|
      str += cb[i]
      rd = PI * (a * @radian) / 180
      margin_x = mx[i]
      margin_y = my[i]
      sx = "%.3f" % (@cx + cos(rd) * @diameter + margin_x)
      sy = "%.3f" % (@cy + sin(rd) * @diameter + margin_y)
      if i == angle.size - 1
        sx = "%.3f" % (@cx + (2 - cos(rd)) * @diameter - mx[0])
        sy = "%.3f" % (@cy + sin(rd) * @diameter - my[0])
      end
      str << %(#{sx}, #{sy} )
    }
    str << %(#{(@cx + @diameter).to_s}, #{@cy.to_s} z" )
    str
  end
end

f = open("color_transparency.svg", "w") 
header = Canvas.new(1000, 1000, "color_transparency")
f.write(header.canvas)
cn = [0, 90, 45, 135]
ct = ['20, 20','10, -970','20, 10','-650,-900']
2.times{|i|
  f.write %(<g transform="rotate(#{cn[i].to_s})">\n)
  f.write %(<g transform="translate(#{ct[i]})">\n)
  f.write %(<g stroke-width="0.3">\n)
  f.write %(<g fill-opacity="0.3">\n)
  1800.times{|j|
    f.write %(<path d=")
    line = Line.new(j)
    f.write(line.draw)
    color = Transparency.new
    # cellophane, leaf, berry, lavender, orange or monotone
    f.write(color.cellophane)
  }
  f.write %(</g>\n</g>\n</g>\n</g>\n)
}
f.write %(</svg>\n)
f.close
