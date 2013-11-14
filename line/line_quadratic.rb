
require_relative '../lib/svg_canvas'

# header
s = SvgCanvas.new(1000, 1000, "line_quadratic")
f = s.header

# main
f.write %(<g fill="none" stroke-width="0.3">\n)
var = [
  ['999', 0.9, 2.6],
  ['778', 0.2, 1.1]
]
half = 500
limit = 550
2.times{|i|
  f.write %(<g stroke="##{var[i][0]}">\n)
  ary = []
  var[i][1].step(var[i][2], 0.01) {|n| ary << n }
  4.times{|j|
    ary.each{|k|
      str = ""
      n = 1
      sy = 0
      while (n <= half && sy <= limit)
        str += "-" if j == 0 || j == 2
        if i == 0
          vy = "%.3f" % ((n ** k - (n - 1) ** k) / 22).to_s
          sy = (n ** k) / 22
        else
          vy = "%.3f" % ((n ** k - (n - 1) ** k) * 5).to_s
          sy = (n ** k) * 5
        end
        str += "1 "
        str += "-" if j == 1 || j == 2
        str += vy
        n += 1
        str += "," unless (n > half || sy > limit)
      end
      f.write %(<path d="M#{half} #{half} l#{str}" />\n)
    }
  }
  f.write %(</g>\n)
}
f.write %(</g>\n)

# footer
s.footer
