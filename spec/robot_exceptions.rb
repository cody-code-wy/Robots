require 'spec_helper'

describe Robot do

  before :each do
    @robot = Robot.new
    @enemy = Robot.new
    @bread = Item.new("Bread",20)
  end

  describe "#heal!" do

    it 'should not raise exception when healing living robot' do
      expect { @robot.heal!(10) }.to_not raise_error
    end

    it 'should call #heal' do
      expect(@robot).to receive(:heal).with(10)
      @robot.heal!(10)
    end

    it 'should raise exception when healing dead robot' do 
      expect(@robot).to receive(:health) {0}
      expect { @robot.heal!(10) }.to raise_error(DeadRobotError)
    end

  end

  describe "#attack!" do

    it 'should not raise exception when attacking robot' do
      expect { @robot.attack!(@enemy) }.to_not raise_error
    end

    it 'should call #attack' do
      expect(@robot).to receive(:attack).with(@enemy)
      @robot.attack!(@enemy)
    end

    it 'should raine exception when attacking non robot' do
      expect { @robot.attack!(@bread) }.to raise_error(NotARobot)
    end
  end

end
