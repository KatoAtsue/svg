require 'rubygems'
require 'RMagick'

include Magick

photo = ImageList.new("tsubaki1.jpg")

bx = 1280
by = 900

x = 1250
y = 370

def blur
#  [0.5, 0, -0.5][rand(3)]
  [0.3, 0.4, -0.4, -0.3, 0][rand(5)]
end

f = open("mosaic.svg", "w") 
f.write(<<"EOS"
<?xml version="1.0" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" 
 "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1"
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  width="#{bx}" height="#{by}"
  viewBox="0 0 #{bx} #{by}">
<title>mosaic</title>
<rect x="0" y="0" fill="#fff" width="#{bx}" height="#{by}" />
EOS
)
#---------------
# mosaic
#---------------
sp = [
	[688, 0.75, 3],
	[560, 0.7, -3],
	[280, 0.7, 2],
	[120, 1.2, -0.07],
	[815, 1.2, 0.07],
	[30, 0.7, 3]
	]

6.times{|n|
c_str = ""
w_str = ""

sp[n][0].step(y + sp[n][0], 8.5){|j|
	move_x = 0
	pre_arch = 0

	0.step(x, 16.5){|i|
    
    mx = move_x + blur
    my = j + blur - pre_arch

		cv = photo.pixel_color(mx + 7, my + 3.5)
		rgb = sprintf("%02x%02x%02x", cv.red, cv.green, cv.blue)

    length = 15.0 - rand(5)
    lx = length + blur

    arch = ((move_x + lx) ** sp[n][1]) * sp[n][2]
    arch_relative = arch - pre_arch

# color area
#-----------------
    uy1 = "%0.3f" % (blur - arch_relative*(3/length))
		uy2 = "%0.3f" % (blur - arch_relative*(10/length))
		uy3 = "%0.3f" % (blur - arch_relative)
		u_side = "3, #{uy1} 9, #{uy2} #{lx.to_s}, #{uy3}"
		w_u_side = "5, #{uy1} 11, #{uy2} #{(lx + 4).to_s}, #{uy3}"

    rx1 = blur.to_s
		rx2 = blur.to_s
		rx3 = blur.to_s
		ry1 = 7 + blur
		w_ry1 = (ry1 + 3.6).to_s
    r_side = "#{rx1}, 3 #{rx2}, 4 #{rx3}, #{ry1.to_s}"
    w_r_side = "#{rx1}, 4.8 #{rx2}, 5.8 #{rx3}, #{w_ry1}"

		dx1 = -length + blur
	  dy1 = "%0.3f" % (blur + arch_relative * (3 / length))
		dy2 = "%0.3f" % (blur + arch_relative * (10 / length))
		dy3 = "%0.3f" % (blur + arch_relative)
		w_dx1 = (dx1 - 4).to_s
		d_side = "-3, #{dy1} -9, #{dy2}  #{dx1.to_s}, #{dy3}"
		w_d_side = "-5, #{dy1} -11, #{dy2}  #{w_dx1}, #{dy3}"

		lx1 = mx + blur
		lx2 = mx + blur
		lx3 = mx.to_s
		ly1 = "%0.3f" % (my + 4)
		ly2 = "%0.3f" % (my + 3)
		ly3 = "%0.3f" % my
		w_lx1 = (lx1 - 2).to_s
		w_lx2 = (lx2 - 2).to_s
		w_lx3 = (mx - 2).to_s
		w_ly1 = "%0.3f" % (my + 5.8)
		w_ly2 = "%0.3f" % (my + 4.8)
		w_ly3 = "%0.3f" % (my - 1.8)
    l_side = "#{lx1.to_s}, #{ly1} #{lx2.to_s}, #{ly2} #{lx3}, #{ly3}"
    w_l_side = "#{w_lx1}, #{w_ly1} #{w_lx2}, #{w_ly2} #{w_lx3}, #{w_ly3}"

    w_str += %(<path d="M#{(mx - 2).to_s} #{"%0.3f" % (my - 1.8)} c#{w_u_side} c#{w_r_side} c#{w_d_side} C#{w_l_side} z" fill="#fff" />\n)
    c_str += %(<path d="M#{mx.to_s} #{"%0.3f" % my} c#{u_side} c#{r_side} c#{d_side} C#{l_side} z" fill="##{rgb}" />\n)

    move_x += 1.5 + length
    pre_arch = arch
  }
}
f.write w_str
f.write c_str
}
f.write %(</svg>\n)
f.close

#mosaic_data = ImageList.new("mosaic.svg")
#mosaic_data.write("mosaic.png")

