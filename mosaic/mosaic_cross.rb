
require_relative '../lib/svg_canvas'

x = 1000
y = 700

# not uniform
def nu
#  [0.3, 0.4, 0.5, -0.5, -0.4, -0.3, 0].sample
  [0.3, 0.4, 0.5, 0].sample
end

def nus
  nu.to_s
end

# %0.3f format
def f03(n)
	"%0.3f" % n
end
# color set
color = Array.new(100){|i| [i ** 1.2 / 1.5, 255 - i ** 1.2 / 1.5, rand(3) * 0.1 + 0.7]}

# mosaic positon angle
sp = [
  [150, 0.75, 3],
  [250, 0.7, -2.2],
  [150, 0.75, 3],
  [278, 0.7, 2],
  [60, 1.25, -0.03],
  [-220, 1.26, -0.057],
  [735, 1.19, 0.079],
]

# header
s = SvgCanvas.new(1000, 1200, "mosaic_cross")
f = s.header

# main
f.write %(<rect x="0" y="0" fill="#fff" width="1000" height="900" />)

2.times{|n|
  c_str = ""
  w_str = ""

  sp[n][0].step(y + sp[n][0], 8.5){|j|
    move_x = 0
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

      arch = ((move_x + lx) ** sp[n][1]) * sp[n][2]
      arch_relative = arch - pre_arch

      # mosaic
      ix = mx.to_s
      iy = f03(my)
      w_ix = (mx - 2).to_s
      w_iy = "%0.3f" % (my - 1.8)

      uy1 = f03(nu - arch_relative * (3 / length))
      uy2 = f03(nu - arch_relative * (10 / length))
      uy3 = f03(nu - arch_relative)

      ry1 = 7 + nu
      w_ry1 = (ry1 + 3.6).to_s

      dx1 = -length + nu
      dy1 = f03(nu + arch_relative * (3 / length))
      dy2 = f03(nu + arch_relative * (10 / length))
      dy3 = f03(nu + arch_relative)
      w_dx1 = (dx1 - 4).to_s

      lx1 = mx + nu
      lx2 = mx + nu
      ly1 = f03(my + 4)
      ly2 = f03(my + 3)
      w_lx1 = f03(lx1 - 2)
      w_lx2 = f03(lx2 - 2)
      w_ly1 = f03(my + 5.8)
      w_ly2 = f03(my + 4.8)

      ip = "M#{ix} #{iy}"
      u_side = "c3, #{uy1} 9, #{uy2} #{lx.to_s}, #{uy3}"
      r_side = "c#{nus}, 3 #{nus}, 4 #{nus}, #{ry1.to_s}"
      d_side = "c-3, #{dy1} -9, #{dy2}  #{dx1.to_s}, #{dy3}"
      l_side = "C#{f03(lx1)}, #{ly1} #{f03(lx2)}, #{ly2} #{ix}, #{iy}"

      w_ip = "M#{w_ix} #{w_iy}"
			w_u_side = "c5, #{uy1} 11, #{uy2} #{(lx + 4).to_s}, #{uy3}"
      w_r_side = "c#{nus}, 4.8 #{nus}, 5.8 #{nus}, #{w_ry1}"
      w_d_side = "c-5, #{dy1} -11, #{dy2}  #{w_dx1}, #{dy3}"
      w_l_side = "C#{w_lx1}, #{w_ly1} #{w_lx2}, #{w_ly2} #{w_ix}, #{w_iy}"

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
