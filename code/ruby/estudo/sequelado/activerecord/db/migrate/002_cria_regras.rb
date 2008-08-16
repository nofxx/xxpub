class CriaRegras < ActiveRecord::Migration  
  def self.up  
    create_table :roles do |t|  
      t.string :name, :null => false
      t.integer :valor, :null => false  
    end  
  end  
  
  def self.down  
    drop_table :roles  
  end  
end