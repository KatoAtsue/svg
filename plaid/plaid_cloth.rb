
class Line
  def initialize(j)
    @int = 9
    @j = j
    @wx = [250, 100, 50, 25].sample
    @ht = rand(-8..16)
  end

  def mv
    str = %(M0, #{(@j * @int).to_s} )
  end

  def right
    str = 'Q'
    (500 / @wx).times{|k|
      wy = rand(-5..7)
      str += %(#{((k * 2 + 1) * @wx).to_s}, #{(wy + @j * @int).to_s} )
      str += %(#{((k + 1) * (@wx * 2)).to_s}, #{(@j * @int).to_s} )
    }
    str
  end

  def down
    str = %(L1000, #{((@j + 1) * @int + @ht).to_s} )
  end

  def left
    str = 'Q'
    (500 / @wx).times{|k|
      wy = rand(-3..6)
      str += %(#{(1000 - ((k * 2 + 1) * @wx)).to_s}, #{(wy + (@j + 1) * @int + @ht).to_s} )
      str += %(#{(1000 - ((k + 1) * (@wx * 2))).to_s}, #{((@j + 1) * @int + @ht).to_s} )
    }
    str
  end

  def up
    str = %(L0, #{(@j * @int).to_s} )
  end

end

f = open("plaid_cloth.svg", "w") 
f.write(<<"EOS"
<?xml version="1.0" encoding="utf-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" 
 "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1"
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  width="1200" height="1200"
  viewBox="0 0 1200 1200">
<title>plaid_cloth</title>
EOS
)

cn = [0, 90]
ct = ['20, 20','10, -970']
2.times{|i|
  f.write %(<g transform="rotate(#{cn[i].to_s})">\n)
  f.write %(<g transform="translate(#{ct[i]})">\n)
  f.write %(<g stroke-width="0.3">\n)
  f.write %(<g fill-opacity="0.3">\n)
  110.times{|j|
    rgb = Array.new(3){|i| rand(76)}
    fc = Array.new(3){|i| "%02x" % (rgb[i] + 170)}.join
    wc = Array.new(3){|i| "%02x" % (rgb[i] + 70)}.join
    st = ['none', '#' + wc]
    fl = ['none', '#' + fc]
    l = Line.new(j)
    f.write %(<path d="#{l.mv}#{l.right}#{l.down}#{l.left}#{l.up}" )
    f.write %(fill="#{fl[j % 2]}" stroke="#{st[j % 2]}" />\n)
  }
  f.write %(</g>\n</g>\n</g>\n</g>\n)
}
f.write %(</svg>\n)
f.close
