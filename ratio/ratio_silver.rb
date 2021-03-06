
require_relative '../lib/svg_canvas'
include Math

# silver ratio
def silver(n)
  if n < 2
    return n
  else
    return ((silver(n - 1) * sqrt(2) * 10).round) / 10.0
  end
end

# header
s = SvgCanvas.new(1200, 800, "ratio_silver")
f = s.header

# main
add_sub = [[-1,1,1,-1],[-1,-1,1,1],[1,-1,-1,1],[1,1,-1,-1]]
rot = 30

f.write %(<g stroke="#666" stroke-width="0.3" fill="none">\n)
51.times{|i|
  mx = 360
  my = 360
  ra = []
  rot.times{|n| ra << silver(n + 1)}
  ra.map!{|n| n * 0.002 * (68 - i)}
  rot.times{|j|
    as = add_sub[j % 4]
    mx += ra[j] * as[0]
    my += ra[j] * as[1]
    f.write %(<path d="M#{"%0.2f" % mx},#{"%0.2f" % my} a#{"%0.2f" % ra[j]},#{"%0.2f" % ra[j]} 0 0,0 #{"%0.2f" % (ra[j] * as[2])},#{"%0.2f" % (ra[j] * as[3])} z" />\n)
  }
}
f.write %(</g>\n)

# footer
s.footer
