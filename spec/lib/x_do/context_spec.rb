require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe XDo do
  describe 'with no display specification' do
    let(:xdo) { XDo.new }
    
    it 'should use the value of $DISPLAY' do
      xdo.display_name.should == ENV['DISPLAY']
    end
    
    describe 'after close' do
      before { xdo.close }
      
      it 'should not accept method calls' do
        lambda {
          xdo.display_name
        }.should raise_error(NoMethodError)
      end
      
      it 'should accept #close without crashing' do
        lambda {
          xdo.close
        }.should_not raise_error
      end
    end
  end
  
  describe 'find_windows' do
    let(:xdo) { XDo.new }
    
    describe 'with .* name pattern' do
      let(:windows) { xdo.find_windows :name => '.*' }
      
      it 'should return at least 1 element' do
        windows.should_not be_empty
      end
      
      it 'should return same number of windows as xdotool' do
        windows.length.should == `xdotool search --all --name ".*"`.split.length
      end
      
      it 'should have a XDo::Window as the first element' do
        windows.first.should be_kind_of(XDo::Window)
      end
    end
    
    describe 'with the current PID' do
      let(:windows) { xdo.find_windows :pid => $PID }
      
      it 'should not return any windows for console process' do
        windows.should be_empty
      end
    end
  end
  
  describe 'with :0 display name' do
    let(:display) { ':0'}
    let(:xdo) { XDo.new display }
    
    it 'should use given display name' do
      xdo.display_name.should == display
    end
  end
  
  describe 'lib_version' do
    let(:version) { XDo.lib_version }
    
    it 'should be non-nil' do
      version.should_not be_nil
    end

    it 'should be non-empty' do
      version.should_not be_empty
    end
  end
end
