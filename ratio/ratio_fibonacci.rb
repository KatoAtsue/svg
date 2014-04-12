
require_relative '../lib/svg_canvas'
include Math

# fibonacci
def fib(n)
  if n < 2
    return n
  else
    return fib(n - 2) + fib(n - 1)
  end
end


# header
s = SvgCanvas.new(1500, 1500, "ratio_fibonacci")
f = s.header

# main
add_sub = [[-1,1,1,-1],[-1,-1,1,1],[1,-1,-1,1],[1,1,-1,-1]]
rot = 15

f.write %(<g stroke="#666" stroke-width="0.5" fill="#aaf" fill-opacity="0.1">\n)
17.times{|i|
  mx = 500
  my = 500
  ra = []
  rot.times{|n| ra << fib(n + 1)}
  ra.map!{|n| n * 0.05 * (20 - i)}

  rot.times{|j|
    as = add_sub[j % 4]
    mx += ra[j] * as[0]
    my += ra[j] * as[1]
    f.write %(<path d="M#{mx},#{my} a#{ra[j]},#{ra[j]} 0 0,0 #{ra[j] * as[2]},#{ra[j] * as[3]} z" />\n)
  }
}
f.write %(</g>\n)


# footer
s.footer
