require 'rubygems'
require 'RMagick'

include Magick

photo = ImageList.new("tsubaki1.jpg")

bx = 1000
by = 1000

x = 600
y = 600

def blur
  [0.5, 0, -0.5][rand(3)]
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
value = []
#ary = Array.new(100){|i| [i ** 1.2 / 1.5, 255 - i ** 1.2 / 1.5, rand(5) * 0.1]}
ary = Array.new(100){|i| [i ** 1.2 / 1.5, 255 - i ** 1.2 / 1.5, rand(3) * 0.1 + 0.7]}
value.concat ary

#---------------
# mosaic1 color
#---------------
50.step(y + 50,8.5){|j|
	move_x = 0
	pre_arch = 0

	0.step(x,16.5){|i|
		
    mx = move_x + blur
    my = j + blur - pre_arch

		cv = photo.pixel_color(mx,my)
		rgb = sprintf("%02x%02x%02x", cv.red, cv.green, cv.blue)

		length = 15.0 - rand(5)
    lx = length + blur
#    arch = ((move_x + lx) ** 0.7) * 3
    arch = ((move_x + lx) ** 0.7) * -3

    arch_relative = arch - pre_arch

    u_side = "3, #{"%0.3f" % (blur - arch_relative*(3/length))} 9, #{"%0.3f" % (blur - arch_relative*(10/length))} #{lx.to_s}, #{"%0.3f" % (blur - arch_relative)}"
    r_side = "#{blur.to_s}, 3 #{blur.to_s}, 4 #{blur.to_s}, #{(7 + blur).to_s}"

    d_side = "-3, #{"%0.3f" % (blur + arch_relative*(3/length))} -9, #{"%0.3f" % (blur + arch_relative*(10/length))}  #{(-length + blur).to_s}, #{"%0.3f" % (blur + arch_relative)}"

    l_side = "#{(mx + blur).to_s}, #{"%0.3f" % (my + 4)} #{(mx + blur).to_s}, #{"%0.3f" % (my + 3)} #{mx.to_s}, #{"%0.3f" % my}"

    f.write %(<path d="M#{mx.to_s} #{"%0.3f" % my} c#{u_side} c#{r_side} c#{d_side} C#{l_side} z" fill="##{rgb}" />\n)

    move_x += 1.5 + length
    pre_arch = arch
  }
}

#---------------
# mosaic2 color
#---------------
0.step(y,8.5){|j|
	move_x = 0
	pre_arch = 0

	0.step(x,16.5){|i|
    
    mx = move_x + blur
    my = j + blur - pre_arch

		cv = photo.pixel_color(mx,my)
		rgb = sprintf("%02x%02x%02x", cv.red, cv.green, cv.blue)


    length = 15.0 - rand(5)
    lx = length + blur

#    white_length = length + 1.5
    white_length = 16.5
    white_lx = white_length + 1

    arch = ((move_x + lx) ** 0.7) * 3
    arch_relative = arch - pre_arch


# white area
#----------------
    white_u_side = "3, #{"%0.3f" % (-arch_relative*(3/white_length))} 9, #{"%0.3f" % (-arch_relative*(10/white_length))} #{white_lx.to_s}, #{"%0.3f" % (-arch_relative)}"

#    white_r_side = "0, 3 0, 4 0, 8.5"
    white_r_side = "0, 4 0, 5 0, 9.5"

    white_d_side = "-3, #{"%0.3f" % (arch_relative*(3/white_length))} -9, #{"%0.3f" % ( arch_relative*(10/white_length))}  #{(-white_length).to_s}, #{"%0.3f" % arch_relative}"

    white_l_side = "#{move_x.to_s}, #{"%0.3f" % (my + 4)} #{move_x.to_s}, #{"%0.3f" % (my + 3)} #{move_x.to_s}, #{"%0.3f" % my}"

#    f.write %(<path d="M#{mx.to_s} #{"%0.3f" % my} c#{white_u_side} c#{white_r_side} c#{white_d_side} C#{white_l_side} z" fill="#fff" />\n)

# color area
#-----------------
    uy1 = "%0.3f" % (blur - arch_relative*(3/length))
		uy2 = "%0.3f" % (blur - arch_relative*(10/length))
		uy3 = "%0.3f" % (blur - arch_relative)
		u_side = "3, #{uy1} 9, #{uy2} #{lx.to_s}, #{uy3}"
		w_u_side = "3.5, #{uy1} 9.5, #{uy2} #{(lx + 0.5).to_s}, #{uy3}"

    r_side = "#{blur.to_s}, 3 #{blur.to_s}, 4 #{blur.to_s}, #{(7 + blur).to_s}"
    w_r_side = "0.5, 3.5 0.5, 4.5 0, 8"

    d_side = "-3, #{"%0.3f" % (blur + arch_relative*(3/length))} -9, #{"%0.3f" % (blur + arch_relative*(10/length))}  #{(-length + blur).to_s}, #{"%0.3f" % (blur + arch_relative)}"
    l_side = "#{(mx + blur).to_s}, #{"%0.3f" % (my + 4)} #{(mx + blur).to_s}, #{"%0.3f" % (my + 3)} #{mx.to_s}, #{"%0.3f" % my}"


    f.write %(<path d="M#{mx.to_s} #{"%0.3f" % my} c#{white_u_side} c#{white_r_side} c#{white_d_side} C#{white_l_side} z" fill="#f66" />\n)
#    f.write %(<path d="M#{(mx - 0.5).to_s} #{"%0.3f" % (my - 0.5)} c#{w_u_side} c#{w_r_side} c#{white_d_side} C#{white_l_side} z" fill="#f66" />\n)

    f.write %(<path d="M#{mx.to_s} #{"%0.3f" % my} c#{u_side} c#{r_side} c#{d_side} C#{l_side} z" fill="##{rgb}" />\n)

    move_x += 1.5 + length
    pre_arch = arch
  }
}

f.write %(</svg>\n)
f.close


mosaic_data = ImageList.new("mosaic.svg")
#mosaic_data.write("mosaic.png")

