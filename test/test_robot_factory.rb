
require_relative './minitest_helper.rb'
require_relative '../robot_factory.rb'
require 'pry'

class TestRobotFactory < MiniTest::Test

  def test_robot
    robot = RobotFactory.new.new_robot
    assert_equal nil, robot.name
    robot.boot
    assert_equal 5, robot.name.length
    robot.reset
    assert_equal nil, robot.name
    robot.boot
    assert_equal 5, robot.name.length
  end

end
