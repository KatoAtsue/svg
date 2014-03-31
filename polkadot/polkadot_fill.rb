
require_relative '../lib/svg_canvas'
include Math

class Line
  attr_reader :cx, :cy, :radius

  def initialize(j, rad)
    @j = j
    @cx = rand(800)
    @cy = rand(800)
    @radius = rad
    @radian = [15, 30, 60].sample
  end

  def bz
    n = 0
    case @radian
      when 15 then n = 0.08
      when 30 then n = 0.18
      else n = 0.75
    end
    rand(@radius) * n
  end

  def mv
    sx = @cx + @radius
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
      sx = "%0.3f" % (@cx + cos(rd) * @radius + margin_x)
      sy = "%0.3f" % (@cy + sin(rd) * @radius + margin_y)
      if i == angle.size - 1
        sx = "%0.3f" % (@cx + (2 - cos(rd)) * @radius - mx[0])
        sy = "%0.3f" % (@cy + sin(rd) * @radius - my[0])
      end
      str += %(#{sx}, #{sy} )
    }
    str += %(#{(@cx + @radius).to_s}, #{@cy.to_s}z)
    str
  end
end

# header
s = SvgCanvas.new(800, 800, "polkadot_fill")
f = s.header

# main
used = [[0,0,0]]
j = 0
k = 0
f.write %(<g stroke-width="0.3">\n)
f.write %(<g fill-opacity="0.3">\n)
while k < 200
  suc = (j ** (1.0 / 3.0) / 3).to_int
  suc = 10 if suc > 10
  rad = 13 - suc
  l = Line.new(j,rad)
  overlap = "no"
  used.each{|u|
    if (l.cx - u[0]) ** 2 + (l.cy - u[1]) ** 2 < (rad + u[2]) ** 2
      overlap = "yes"
      k += 1
      break
    end
  }
  if overlap == "no"
    rgb = Array.new(3){|i| rand(76)}
    fc = Array.new(3){|i| "%02x" % (rgb[i] + 170)}.join
    wc = Array.new(3){|i| "%02x" % (rgb[i] + 70)}.join
    f.write %(<path d="#{l.mv}" fill="##{fc}" stroke="##{wc}" />\n)
    used << [l.cx, l.cy, rad]
    k = 0
  end
  j += 1
end
f.write %(</g>\n</g>\n)

# footer
s.footer
