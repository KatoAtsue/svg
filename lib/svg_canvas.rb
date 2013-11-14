# svg template

class SvgCanvas < IO
  def initialize(width, height, title)
    @width = width
    @height = height
    @title = title
    @f = nil
  end

  # svg header
  def header
    @f = open(@title + ".svg", "w")
    @f.write(<<-"EOS"
<?xml version="1.0" encoding="utf-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" 
 "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1"
  xmlns="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  width="#@width" height="#@height"
  viewBox="0 0 #@width #@height">
<title>#@title</title>
    EOS
)
    @f
  end

  # svg footer
  def footer
    @f.write %(</svg>\n)
    @f.close
  end

end
