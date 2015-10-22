class Polygon
  def initialize(*vertices)
    @vertices = vertices
  end

  def vertices
    @vertices.map(&:dup)
  end

  def within?(x, y)
    #method - is the number of line crossings odd?
    count = 0

    #test each line to see if the point (x, y) lies to right of it.
    @vertices.length.times do |idx|
      pt1, pt2 = @vertices[idx], @vertices[(idx + 1) % @vertices.length]
      xs = [pt1[0], pt2[0]]
      ys = [pt1[1], pt2[1]]
      if !(xs.min..xs.max).cover?(x) || ys.min > y
        #line never crosses
        next
      elsif ys.max < y
        #line always crosses
        count += 1
      elsif pt1[1] == pt2[1] || pt1[0] == pt2[0] && pt2[0] == lat
        #edge case
        return true
      else
        #find d(x) / d(y)
        slope = (pt1[1] - pt2[1].to_f) / (pt1[0] - pt2[0].to_f)
        d_x = pt1[0] + x.to_f
        p_y = slope * d_x + pt1[0]
        return true if p_y == y
        count += 1 if p_y < y
      end
    end

    count.odd?
  end
end
