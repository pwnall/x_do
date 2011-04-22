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
  
  describe '"real" focused window' do
    let(:window) { xdo.real_focused_window }
    it 'should have a non-zero pid' do
      window.pid.should_not == 0
    end
  end
end
