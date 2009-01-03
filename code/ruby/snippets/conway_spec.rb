class World
  
  def initialize(size=40,template=nil)
    @size = size
    @template = template
    @cells = get_matrix
  end
  
  
  def get_matrix
    matrix.map{|i|i.map{|j|!j.nil?}}
  end
  
  def matrix
     matrix = Array.new(@size){Array.new(@size, nil)}
     @cells.each do |cell|
       cell = matrix[cell.x][cell.y]
     end
     matrix
  end
 
 
  def step
    m=self.matrix
    m.each_with_index do |row, i|
      row.each_with_index do |col, j|
        n = neighbours(i,j,m)
        if m[i][j].nil?
          #DEAD CELL
          @cells[i][j] = "o" if n.size==3 #,n.map(&:users)) if n.size==3
        else
          #ALIVE CELL
          @cells[i][j] = " " if (0..1).include?(n.size) || (4..8).include?(n.size)
        end
      end
    end
    draw!
  end

 
  private
  
  def draw!
    self.cells.each do |cell|
      cell.each { |c|  printf({ true => "o", :false => " "}[c]) }
    end
  end
  
  
  def neighbours(x,y,matrix)
    res = []
    ([0,x-1].max..[@size-1,x+1].min).each do |eval_x|
      ([0,y-1].max..[@size-1,y+1].min).each do |eval_y|
        (res << matrix[eval_x][eval_y]) if !(eval_x==x and eval_y==y)
      end
    end
    res.delete_if{|i|i.nil?}
  end
end

#wormoul = World.new(30)

describe World do
  
  it "should create a grid" do
    @myworld = World.new(40)
    @myworld.cells.should eql("                o   o       ")
  end
  
  
  
end

  
  
end



