require File.expand_path(File.dirname(__FILE__) + '../../spec_helper')

describe XDo::Keyboard do
  let(:xdo) { XDo.new }
  let(:keyboard) { xdo.keyboard }
  
  describe 'after pressing Alt+Tab' do
    before do
      @old_active_window = xdo.focused_window
      keyboard.type_keysequence 'Alt_L+Tab'
      sleep 0.1
    end
    after do
      keyboard.type_keysequence 'Alt_L+Tab'
      sleep 0.1
    end
    
    it 'should switch the focused window' do
      xdo.focused_window.should_not == @old_active_window
    end
  end
  
  describe 'after typing kbd_injected' do
    before do
      keyboard.type_string "kbd_injected\n"
    end
    
    it 'should reflect the string in gets' do
      $stdin.gets.should == "kbd_injected\n"
    end
  end
end
