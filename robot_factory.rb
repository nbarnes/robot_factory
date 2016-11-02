
class Robot

  attr_reader :name, :factory

  def initialize(factory)
    @factory = factory
  end

  def boot
    @name = @factory.get_new_name
    return self
  end

  def reset
    @factory.free_name(@name)
    @name = nil
    return self
  end

end

# NOTE: The initialization of the factory takes a relatively long time due to construction
# of the name set for future use.  This is necessary to ensure that robot names are as
# unique as possible while also allowing for their re-use if needed
class RobotFactory

  def initialize
    @names = []
    ('A'..'Z').each do |first|
      ('A'..'Z').each do |second|
        ('A'..'Z').each do |third|
          (0..9).each do |fourth|
            (0..9).each do |fifth|
              @names << [first, second, third, fourth, fifth].join
            end
          end
        end
      end
    end
    @available_names = @names
  end

  def new_robot
    return Robot.new(self)
  end

  # If a new available_names array is created and then free_name() is called, there is
  # the potential for duplicate names to exist within available_names and then be
  # assigned to robots.  There are a few potential solutions, but probably the best one
  # is to have longer serial numbers.
  def get_new_name
    @available_names = @names if @available_names.length == 0
    new_name = @available_names.sample
    @available_names.delete new_name
    return new_name
  end

  def free_name(name)
    @available_names << name
  end

end
