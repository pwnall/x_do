require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')

describe XDo::Mouse do
  let(:xdo) { XDo.new }
  let(:mouse) { xdo.mouse }
  
  describe 'location' do
    let(:location) { mouse.location }
    
    it 'should have 3 coordinates' do
      location.should have(3).coordinates
    end
    
    it 'should have non-negative coordinates' do
      location[0].should >= 0
      location[1].should >= 0
      location[2].should >= 0
    end
    
    describe 'after moving' do
      let(:new_location) { [location[0] + 20, location[1] + 20, location[2]] }
      before do
        mouse.move(*new_location)
        mouse.wait_for_move_from location[0], location[1]
      end
      after { mouse.move(*location) }
      
      it 'should change to the move arguments' do
        mouse.location.should == new_location
      end
      
      it 'should not block wait_for_move_to' do
        lambda {
          mouse.wait_for_move_to new_location[0], new_location[1]
        }.should_not raise_error
      end
    end

    describe 'after relative moving' do
      let(:new_location) { [location[0] + 20, location[1] + 20, location[2]] }
      before do
        new_location
        mouse.move_relative 20, 20
        mouse.wait_for_move_from location[0], location[1]
      end
      after { mouse.move(*location) }
      
      it 'should change to the move arguments' do
        mouse.location.should == new_location
      end
    end
  end
end
