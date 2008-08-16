module Testavel
  def test
    p "#{self.class.name} - #{self.object_id} : #{self.to_s}"
  end
end