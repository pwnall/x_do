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
