require 'xc_test'
require 'test/unit'

class TestXcTest < Test::Unit::TestCase
  def test_xc_test
    t = XcTest.new
    assert_equal(Object, XcTest.superclass)
    assert_equal(XcTest, t.class)
    t.add(1)
    t.add(2)
    assert_equal([1,2], t.instance_eval("@arr"))
    assert_equal([1,2], t.arr)
    
    t.somero(20)
    assert_equal(10, t.point)
  end
end