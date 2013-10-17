
x = 250
y = 220

f = open("ellipse_translate.svg", "w") 
f.write(<<"EOS"
<?xml version="1.0" encoding="utf-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" 
  "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1"
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  width="#{x}" height="#{y}"
  viewBox="0 0 #{x} #{y}">
EOS
)
0.step(177,3){|i|
  f.write('<ellipse transform="translate(' + i.to_s + ' 0)" fill="none" stroke="#888"
  cx="40" cy="110" rx="30" ry="100" stroke-width="0.3" />' + "\n")
}
f.write("</svg>\n")
f.close
