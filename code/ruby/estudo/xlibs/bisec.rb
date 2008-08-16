include "Vector"

class Geometry

  def initialize
    @radians_to_degrees = (180/Math::PI)
    @degrees_to_radians = (Math::PI/180)
  end

  def line_angle(x1, y1, x2, y2)
    return (Math.atan2(y2-y1,x2-x1)) * @radians_to_degrees
  end

  def bisected_angle(point_01, axis_point, point_03)
    b = point_01 - axis_point
    a = line_length(axis_point,point_03)
    c = line_length(point_01,point_03)
    angle = (Math.acos(((a ** 2) + (b ** 2) - (c ** 2)) / 2 * (a * b)) * @radians_to_degrees)
    return angle / 2
  end

end

x = Vector[10,5]

puts Geometry.new.bisected_angle(Vector[200,270], Vector[400,120], Vector[400,0])