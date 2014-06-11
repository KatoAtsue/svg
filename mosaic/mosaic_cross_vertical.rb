
require_relative '../lib/svg_canvas'

x = 1000
y = 350

# not uniform
def nu
  [0.3, 0.4, 0.5, -0.5, -0.4, -0.3, 0].sample
end

def nus
  nu.to_s
end

# color set
color = Array.new(100){|i| [i ** 1.2 / 1.5, 255 - i ** 1.2 / 1.5, rand(3) * 0.1 + 0.7]}

# mosaic positon angle
sp = [
  [1, 80, 0.75, 3],
  [1, 180, 0.7, -2],
  [2, 380, 0.75, 3],
  [2, 280, 0.7, -2],
  [1, 278, 0.7, 2],
  [2, 60, 1.25, -0.03]
#  [-220, 1.26, -0.057],
#  [735, 1.19, 0.079],
#  [58, 0.7, 3]
  ]

# header
s = SvgCanvas.new(1000, 900, "mosaic_cross_vertical")
f = s.header

# main
f.write %(<rect x="0" y="0" fill="#fff" width="1000" height="900" />)

# horizontal
6.times{|n|
  c_str = ""
  w_str = ""

  sp[n][1].step(y + sp[n][1], 8.5){|j|
#    move_x = 0
    move_x = 30
    pre_arch = 0

    0.step(x, 16.5){|i|
      mx = move_x + nu
      my = j + nu - pre_arch

      v = color.sample
      b = rand(v[0]) + v[1]
      rg = b * v[2]
      rgb = sprintf("#%02x%02x%02x", rg, rg, b)

      length = 15.0 - rand(5)
      lx = length + nu

#      arch = ((move_x + lx) ** sp[n][2]) * sp[n][3]
      arch = ((move_x - 30 + lx) ** sp[n][2]) * sp[n][3]
      arch_relative = arch - pre_arch

      # mosaic
      ix = mx.to_s
      iy = "%0.3f" % my
      w_ix = (mx - 2).to_s
      w_iy = "%0.3f" % (my - 1.8)

      uy1 = "%0.3f" % (nu - arch_relative * (3 / length))
      uy2 = "%0.3f" % (nu - arch_relative * (10 / length))
      uy3 = "%0.3f" % (nu - arch_relative)

      ry1 = 7 + nu
      w_ry1 = (ry1 + 3.6).to_s

      dx1 = -length + nu
      dy1 = "%0.3f" % (nu + arch_relative * (3 / length))
      dy2 = "%0.3f" % (nu + arch_relative * (10 / length))
      dy3 = "%0.3f" % (nu + arch_relative)
      w_dx1 = (dx1 - 4).to_s

      lx1 = mx + nu
      lx2 = mx + nu
      ly1 = "%0.3f" % (my + 4)
      ly2 = "%0.3f" % (my + 3)
      w_lx1 = (lx1 - 2).to_s
      w_lx2 = (lx2 - 2).to_s
      w_ly1 = "%0.3f" % (my + 5.8)
      w_ly2 = "%0.3f" % (my + 4.8)

      if sp[n][0] == 1

        ip = "M#{ix} #{iy}"
        u_side = "c3, #{uy1} 9, #{uy2} #{lx.to_s}, #{uy3}"
        r_side = "c#{nus}, 3 #{nus}, 4 #{nus}, #{ry1.to_s}"
        d_side = "c-3, #{dy1} -9, #{dy2}  #{dx1.to_s}, #{dy3}"
        l_side = "C#{lx1.to_s}, #{ly1} #{lx2.to_s}, #{ly2} #{ix}, #{iy}"

        w_ip = "M#{w_ix} #{w_iy}"
        w_u_side = "c5, #{uy1} 11, #{uy2} #{(lx + 4).to_s}, #{uy3}"
        w_r_side = "c#{nus}, 4.8 #{nus}, 5.8 #{nus}, #{w_ry1}"
        w_d_side = "c-5, #{dy1} -11, #{dy2}  #{w_dx1}, #{dy3}"
        w_l_side = "C#{w_lx1}, #{w_ly1} #{w_lx2}, #{w_ly2} #{w_ix}, #{w_iy}"

      else
        ip = "M#{iy} #{ix}"
        u_side = "c#{uy1}, 3 #{uy2}, 9 #{uy3}, #{lx.to_s}"
        r_side = "c3, #{nus}, 4, #{nus} #{ry1.to_s}, #{nus}"
        d_side = "c#{dy1}, -3 #{dy2}, -9  #{dy3}, #{dx1.to_s}"
        l_side = "C#{ly1}, #{lx1.to_s} #{ly2},  #{lx2.to_s} #{iy}, #{ix}"

        w_ip = "M#{w_iy} #{w_ix}"
        w_u_side = "c#{uy1}, 5 #{uy2}, 11 #{uy3}, #{(lx + 4).to_s}"
        w_r_side = "c4.8, #{nus} 5.8, #{nus} #{w_ry1}, #{nus}"
        w_d_side = "c#{dy1}, -5 #{dy2}, -11 #{dy3}, #{w_dx1}"
        w_l_side = "C#{w_ly1}, #{w_lx1} #{w_ly2}, #{w_lx2}, #{w_iy}, #{w_ix}"

      end

      w_str += %(<path d="#{w_ip} #{w_u_side} #{w_r_side} #{w_d_side} #{w_l_side} z" fill="#fff" />\n)
      c_str += %(<path d="#{ip} #{u_side} #{r_side} #{d_side} #{l_side} z" fill="#{rgb}" />\n)

      move_x += 1.5 + length
      pre_arch = arch
    }
  }
  f.write w_str
  f.write c_str
}

# footer
s.footer
