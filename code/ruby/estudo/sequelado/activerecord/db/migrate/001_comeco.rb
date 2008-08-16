class Comeco < ActiveRecord::Migration  
  def self.up  
    create_table :users do |t|  
      t.string :name, :null => false, :limit => 10 # sqlite nao liga
      t.integer :idade, :limit => 150
      t.boolean :sexo, :default => true
      t.date :nasc
      t.decimal :salario # :precision => numero
      t.float :bonus # :scale => numero
      t.text :historia
      t.time :agora, :ontem, :amanha
      
      t.timestamp  
    end  
  end  
  
  def self.down  
    drop_table :users  
  end  
end