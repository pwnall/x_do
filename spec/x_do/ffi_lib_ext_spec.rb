require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')

describe XDo::FFILib do
  describe 'XDoSearch#from_options' do
    describe 'with no flag' do
      let(:search) do
        XDo::FFILib::XDoSearch.from_options
      end
      
      it 'should set flags to 0' do
        search[:searchmask].should == 0
      end
      
      it 'should set require to AND' do
        search[:require].should == 1
      end
      
      it 'should set maximum depth to -1' do
        search[:max_depth].should == -1
      end
    end
    
    describe 'with a set maximum depth' do
      let(:search) do
        XDo::FFILib::XDoSearch.from_options :depth => 42
      end
      
      it 'should not set any flags' do
        search[:searchmask].should == 0
      end

      it 'should set field correctly' do
        search[:max_depth].should == 42
      end
    end

    describe 'with require set to :any' do
      let(:search) do
        XDo::FFILib::XDoSearch.from_options :require => :any
      end
      
      it 'should not set any flags' do
        search[:searchmask].should == 0
      end

      it 'should set require correctly' do
        search[:require].should == 0
      end
    end

    describe 'with 1 boolean flag' do
      let(:search) do
        XDo::FFILib::XDoSearch.from_options :visible => true
      end
      
      it 'should set flags correctly' do
        search[:searchmask].should == XDo::FFILib::Consts::SEARCH_ONLYVISIBLE
      end

      it 'should set fields correctly' do
        search[:only_visible].should == 1
      end
    end

    describe 'with 1 int flag' do
      let(:search) do
        XDo::FFILib::XDoSearch.from_options :screen => 42
      end
      
      it 'should set flags correctly' do
        search[:searchmask].should == XDo::FFILib::Consts::SEARCH_SCREEN
      end

      it 'should set field correctly' do
        search[:screen].should == 42
      end
    end

    describe 'with 1 string flag' do
      let(:search) do
        XDo::FFILib::XDoSearch.from_options :class => 'Normal'
      end
      
      it 'should set flags correctly' do
        search[:searchmask].should == XDo::FFILib::Consts::SEARCH_CLASS
      end

      it 'should set fields correctly' do
        search[:winclass].get_string(0).should == 'Normal'
      end
    end
    
    describe 'with 2 string flags' do
      let(:search) do
        XDo::FFILib::XDoSearch.from_options :title => 'Terminal',
                                            :name => 'gnome-terminal'
      end
      
      it 'should set flags correctly' do
        search[:searchmask].should == XDo::FFILib::Consts::SEARCH_NAME |
                                      XDo::FFILib::Consts::SEARCH_TITLE
      end

      it 'should set fields correctly' do
        search[:winname].get_string(0).should == 'gnome-terminal'
        search[:title].get_string(0).should == 'Terminal'
      end
    end
    
    describe 'with mixed flags' do
      let(:search) do
        XDo::FFILib::XDoSearch.from_options :class_name => 'rbx', :pid => 42
      end
      
      it 'should set flags correctly' do
        search[:searchmask].should == XDo::FFILib::Consts::SEARCH_CLASSNAME |
                                      XDo::FFILib::Consts::SEARCH_PID
      end

      it 'should set fields correctly' do
        search[:winclassname].get_string(0).should == 'rbx'
        search[:pid].should == 42
      end
    end
  end
end
