
class Line
  def initialize(j,dr)
    @int = 20
    @j = j
    @dr = dr
    @wx = [250, 100, 50, 25].sample
  end

  def col
    str = 'Q'
    (500 / @wx).times{|k|
      wx = (k * 2 + 1) * @wx
      @dr == 3 ? str += (1000 - wx).to_s : str += wx.to_s
      str += %(,)
      wy = @j * @int + rand(7) - 3
      @dr == 1 ? str += wy.to_s : str += (wy + @int).to_s
      str += %( )
      wx = (k * 2 + 2) * @wx
      @dr == 3 ? str += (1000 - wx).to_s : str += wx.to_s
      str += %(,)
      wy = @j * @int
      @dr == 1 ? str += wy.to_s : str += (wy + @int).to_s
      str += %( )
    }
    str
  end

  def mv
    str = %(M)
    @dr == 2 ? str += '1000' : str += '0'
    str += %(, #{(@j * @int).to_s} )
  end

  def down
    str = %(L)
    @dr == 2 ? str += '0' : str += '1000'
    str += %(, #{(@j * @int + @int).to_s} )
  end

  def up
    str = %(L)
    @dr == 2 ? str+= '1000' : str += '0'
    str += %(, #{(@j * @int).to_s} )
  end
end

f = open("plaid_color_filled.svg", "w") 
f.write(<<"EOS"
<?xml version="1.0" encoding="utf-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" 
 "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1"
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  width="1200" height="1200"
  viewBox="0 0 1200 1200">
<title>plaid_color_filled</title>
EOS
)
cn = [0, 90]
ct = ['20, 20','0, -1100']
2.times{|i|
  f.write %(<g transform="rotate(#{cn[i].to_s})">\n)
  f.write %(<g transform="translate(#{ct[i]})">\n)
  f.write %(<g stroke-width="0.3">\n)
  f.write %(<g fill-opacity="0.3">\n)
  rec = ""
  for j in 0..99
    rgb = Array.new(3){|i| rand(76)}
    fc = Array.new(3){|i| "%02x" % (rgb[i] + 170)}.join
    wc = Array.new(3){|i| "%02x" % (rgb[i] + 70)}.join
    f.write %(<path d=")
    if j == 0
      l = Line.new(j, 1)
      f.write %(#{l.mv}#{l.col}#{l.down})
      l = Line.new(j, 3)
    elsif j % 2 == 1
      l = Line.new(j, 2)
      f.write %(#{l.mv}#{rec}#{l.down})
    else
      l = Line.new(j, 3)
      f.write %(#{l.mv}#{rec}#{l.down})
    end
    rec = l.col
    f.write %(#{rec}#{l.up}" fill="##{fc}" stroke="##{wc}" />\n)
  end
  f.write %(</g>\n</g>\n</g>\n</g>\n)
}
f.write %(</svg>\n)
f.close
