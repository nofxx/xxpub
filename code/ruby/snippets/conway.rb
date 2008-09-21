class World
  attr_reader :cells
  
  def initialize(size=40,template=nil)
    @size = size
    @template = template
    @cells = matrix
  end
    
  def matrix
     matrix = Array.new(@size){Array.new(@size, nil)}
     matrix.map { |i| i.map { |j| j = true if rand(5) == 1 }}
  end
  
  def step!
    m=matrix.dup
    m.each_with_index do |row, i|
      row.each_with_index do |col, j|
        n = neighbours(i,j,m)
        if m[i][j].nil?
          #DEAD CELL
          @cells[i][j] = true if n.size==3 
        else
          #ALIVE CELL
#          p n.size
          @cells[i][j] = nil if (0..1).include?(n.size) || (4..8).include?(n.size)
        end
      end
    end
    draw!
  end

  def draw!
    out = ''
    # @cells.each do |cell|
    #     cell.each do |c| 
    #       out << ({ true => " o ", nil => "   "}[c]) 
    #     end
    #     out << "\n"
    #   end
    print "\n%s", each_cell { |c| puts ({ true => " o ", nil => "   "}[c]) }
  end
  
  private
  def each_cell
    @cells.each do |row|
      row.each do |cell|
        yield cell
      end
    end
  end
  
  def neighbours(x,y,matrix)
    res = []
    ([0,x-1].max..[@size-1,x+1].min).each do |eval_x|
      ([0,y-1].max..[@size-1,y+1].min).each do |eval_y|
        (res << matrix[eval_x][eval_y]) unless eval_x==x && eval_y==y
      end
    end
#    res.delete_if{|i|i.nil?}
 res
  end
end


wormoul = World.new(30)

while true
  wormoul.draw!
  wormoul.step!
  sleep(0.2)
end


# 
# describe World do
#   before(:each) do
#     @myworld = World.new(10)
#   end  
#   
#   it "should create a grid" do
#     @myworld.matrix.should eql("                o   o       ")
#   end
#   
#   it "should draw the grid" do
#     STDOUT.should_receive(:printf).with('')
#     @myworld.draw!
#   end
#   
#   
# end

  
  


