
x = 1200
y = 1000
f = open("mosaic_square.svg", "w") 
f.write(<<"EOS"
<?xml version="1.0" encoding="utf-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" 
 "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1"
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  width="#{x}" height="#{y}"
  viewBox="0 0 #{x} #{y}">
<title>mosaic_square</title>
EOS
)
0.step(x,10){|i|
  0.step(y,10){|j|
    ratio = [0.85, 0.82, 0.8, 0.78, 0.75, 0.73, 0.7, 0.5, 0.3, 0].sample
    r = rand(160..220)
    g = rand(15) + r + 20
    b = rand(15) + (r * ratio).to_i
    rgb = sprintf("#%02x%02x%02x", r, g, b)
    f.write %(<rect x="#{i.to_s}" y="#{j.to_s}" fill="#{rgb}" width="9" height="9" />\n)
  }
}
f.write %(</svg>\n)
f.close
