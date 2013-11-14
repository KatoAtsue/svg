
require_relative '../lib/svg_canvas'

# header
s = SvgCanvas.new(1200, 1200, "line_translate")
f = s.header

# main
int = 5
cn = [0, 45, 90, 135]
ct = ['20, 20','20, 10','0, -1100','-650,-900']
4.times{|i|
  f.write %(<g transform="rotate(#{cn[i].to_s})">\n)
  f.write %(<g transform="translate(#{ct[i]})">\n)
  f.write %(<g stroke-width="0.3" fill-opacity="0.3">\n)
  100.times{|j|
    rgb = [rand(76), rand(76), rand(76)]
    crgb = sprintf("#%02x%02x%02x", rgb[0] + 180, rgb[1] + 180, rgb[2] + 180)
    wrgb = sprintf("#%02x%02x%02x", rgb[0] + 90, rgb[1] + 90, rgb[2] + 90)
    st1 = ['none', wrgb]
    st2 = ['none', crgb]
    wd = (j * int).to_s
    nx = ((j + 1) * int).to_s
    f.write %(<path d="M0, #{wd} L1160, #{wd} L1160, #{nx} L0, #{nx} L0, #{wd}" )
    f.write %(fill="#{(st2[j % 2])}" stroke="#{(st1[j % 2])}" />\n)
  }
  f.write %(</g>\n</g>\n</g>\n)
}

# footer
s.footer
