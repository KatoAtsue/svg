
include Math

f = open("line_rotate.svg", "w") 
f.write(<<"EOS"
<?xml version="1.0" encoding="utf-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
 "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1"
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  width="1200" height="1200"
  viewBox="0 0 1200 1200">
  <title>line_rotate</title>
EOS
)
int = 5
cn = ['0 0,0',
      '45 35,-110',
      '90 450,450',
      '135 450,230']
st = ['none','#aaa']
4.times{|i|
  f.write %(<g transform="rotate(#{cn[i].to_s})" )
  f.write %(stroke-width="0.3" fill-opacity="0.1">\n)
  100.times{|j|
    rgb = sprintf("%02x%02x%02x", rand(256), rand(256), rand(256))
    wd = (j * int).to_s
    nx = ((j + 1) * int).to_s
    f.write %(<path d="M0, #{wd} L1500, #{wd} L1500, #{nx} L0, #{nx} L0, #{wd})
    f.write %(" fill="##{rgb}" stroke="#{(st[j % 2])}" />\n)
  }
  f.write %(</g>\n)
}
f.write %(</svg>\n)
f.close
