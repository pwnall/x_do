require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')

describe XDo::Window do
  let(:xdo) { XDo.new }
  let(:all) { xdo.find_windows }
  
  describe 'last window' do
    let(:window) { all.last }
    
    it 'should == another instance with the same window id' do
      window.should == XDo::Window.new(xdo, window._window)
    end

    it 'should hash to the same value as another instance with the same window id' do
      window.hash.should == XDo::Window.new(xdo, window._window).hash
    end
    
    it 'should not == an instance with a different id' do
      window.should_not == XDo::Window.new(xdo, window._window + 1)
    end

    it 'should not == a string' do
      window.should_not == "window"
    end

    it 'should not == its id' do
      window.should_not == window._window
    end
  end
  
  describe 'active window' do
    let(:window) { xdo.active_window }
    it 'should have a non-zero pid' do
      window.pid.should_not == 0
    end
    
=begin
    describe 'location' do
      let(:location) { window.location }
      
      it 'should have 2 coordinates' do
        location.should have(2).coordinates
      end
      
      it 'should have non-negative coordinates' do
        location.first.should >= 0
        location.last.should >= 0
      end
      
      describe 'after moving' do
        let(:new_location) { [location.first + 200, location.last + 200] }
        before { window.move(*new_location) }
        after { window.move(*location) }
        
        it 'should change to the move arguments' do
          window.location.should == new_location
        end
      end
    end
=end

    describe 'size' do
      let(:size) { window.size }
      
      it 'should have 2 dimensions' do
        size.should have(2).dimensions
      end
      
      it 'should have positive dimensions' do
        size.first.should > 0
        size.last.should > 0
      end
      
      describe 'after resizing' do
        let(:new_size) { [size.first + 100, size.last + 100 ] }

        before { window.resize(*new_size) }
        after { window.resize(*size) }
        
        it 'should change to approximately the resize arguments' do
          window.size.first.should be_within(10).of(new_size.first)
          window.size.last.should be_within(50).of(new_size.last)
        end
      end
    end
  end
end
