
require_relative '../lib/svg_canvas'

# not uniform
def nu
  [0.3, 0.4, 0.5, -0.5, -0.4, -0.3, 0].sample
end

def nus
  [0.3, 0.4, 0.5, -0.5, -0.4, -0.3, 0].sample.to_s
end

# color set
value = []
ary = Array.new(100){|i| [i ** 1.2 / 1.5, 255 - i ** 1.2 / 1.5, rand(3) * 0.1 + 0.7]}
value.concat ary

# header
s = SvgCanvas.new(1000, 900, "mosaic_tile")
f = s.header

# main
0.step(1000, 8.5){|j|
  move_x = 0
  0.step(1000, 16.5){|i|
    mx = move_x + nu
    my = j + nu

    v = value.sample
    b = rand(v[0]) + v[1]
    rg = (b * v[2]).to_i
    rgb = sprintf("#%02x%02x%02x", rg, rg, b)

    length = 15.0 - rand(5)
    lx = length + nu

    # mosaic
    u_side = "3, #{nus} 9, #{nus} #{lx.to_s}, #{nus}"
    r_side = "#{nus}, 3 #{nus}, 4 #{nus}, #{(7 + nu).to_s}"
    d_side = "-3, #{nus} -9, #{nus}  #{(-length + nu).to_s}, #{nus}"

    lx1 = "%0.3f" % (mx + nu)
    lx2 = "%0.3f" % (mx + nu)
    lx3 = "%0.3f" % mx
    ly1 = "%0.3f" % (my + 4)
    ly2 = "%0.3f" % (my + 3)
    ly3 = "%0.3f" % my
    l_side = "#{lx1.to_s}, #{ly1} #{lx2.to_s}, #{ly2} #{lx3}, #{ly3}"

    f.write %(<path d="M#{lx3} #{ly3} c#{u_side} c#{r_side} c#{d_side} C#{l_side} z" fill="#{rgb}" />\n)

    move_x += 1.5 + length
  }
}

# footer
s.footer
