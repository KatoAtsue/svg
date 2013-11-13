
x = 1000
y = 1000
f = open("line_quadratic.svg", "w") 
f.write(<<"EOS"
<?xml version="1.0" encoding="utf-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
 "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1"
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  width="#{x}" height="#{y}"
  viewBox="0 0 #{x} #{y}">
<title>line_quadratic</title>
EOS
)
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
f.write %(</svg>\n)
f.close
