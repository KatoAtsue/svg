
require_relative '../lib/svg_canvas'
include Math

# header
s = SvgCanvas.new(1200, 1200, "line_rotate")
f = s.header

# main
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

# footer
s.footer
