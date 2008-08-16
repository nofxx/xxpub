class Turtle
   include Math # turtles understand math methods
   DEG = Math::PI / 180.0

   attr_accessor :track
   alias run instance_eval

   def initialize
     clear
   end

   attr_reader :xy, :heading

   # Place the turtle at [x, y]. The turtle does not draw when itchanges
   # position.
   def xy=(coords)
   	 raise ArgumentError if !coords.is_a?(Array) ||
   	                        coords.size != 2 ||
   	                        coords.any? { |c| !c.is_a?(Numeric) }
   	 @xy = coords
   end

   # Set the turtle's heading to <degrees>.
   def heading=(degrees)
   	 raise ArgumentError if !degrees.is_a?(Numeric)
   	 set_heading(degrees)
   end

   # Raise the turtle's pen. If the pen is up, the turtle will notdraw;
   # i.e., it will cease to lay a track until a pen_down command isgiven.
   def pen_up
   	 @pen_down = false
   end

   # Lower the turtle's pen. If the pen is down, the turtle will draw;
   # i.e., it will lay a track until a pen_up command is given.
   def pen_down
   	 @pen_down = true
   end

   # Is the pen up?
   def pen_up?
   	 !@pen_down
   end

   # Is the pen down?
   def pen_down?
   	 @pen_down
   end

   # Places the turtle at the origin, facing north, with its pen up.
   # The turtle does not draw when it goes home.
   def home
   	 pen_up
   	 @xy = [0,0]
   	 @heading = 0
   end

   # Homes the turtle and empties out it's track.
   def clear
   	 home
   	 @track = []
   end

   # Turn right through the angle <degrees>.
   def right(degrees)
     set_heading(@heading + degrees)
   end

   # Turn left through the angle <degrees>.
   def left(degrees)
     set_heading(@heading - degrees)
   end

   # Move forward by <steps> turtle steps.
   def forward(steps)
     dx, dy = calc_delta(steps)
     go [ @xy[0] + dx, @xy[1] + dy ]
   end

   # Move backward by <steps> turtle steps.
   def back(steps)
     dx, dy = calc_delta(steps)
     go [ @xy[0] - dx, @xy[1] - dy ]
   end

   # Move to the given point.
   def go(pt)
     track << [ @xy, pt ] if pen_down?
     @xy = pt
   end

   # Turn to face the given point.
   def toward(pt)
     @heading = atan(pt[0].to_f / pt[1].to_f) / DEG
   end

   # Return the distance between the turtle and the given point.
   def distance(pt)
     sqrt((@xy[0] - pt[0]) ** 2 + (@xy[1] - pt[1]) ** 2)
   end

   # Traditional abbreviations for turtle commands.
   alias fd forward
   alias bk back
   alias rt right
   alias lt left
   alias pu pen_up
   alias pd pen_down
   alias pu? pen_up?
   alias pd? pen_down?
   alias set_h heading=
   alias set_xy xy=
   alias face toward
   alias dist distance

   private
   def set_heading(degrees)
     @heading = degrees % 360
   end

   def calc_delta(steps)
     [ sin(heading * DEG) * steps,
       cos(heading * DEG) * steps ]
   end
end

tuti = Turtle.new
x=0
while (true) do 
  
  x+=1
  raise "bad" if(x==10)
    
end

puts "oi"
  
  