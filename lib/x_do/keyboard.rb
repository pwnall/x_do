# :nodoc: namespace
class XDo

# The keyboard state for a libxdo context.
class Keyboard
  # Creates a keyboard state wrapper for an XDo context.
  #
  # This constructor is called internally by XDo#keyboard and client code
  # should not need to call it directly.
  #
  # Args:
  #   xdo:: the XDo wrapping a libxdo context
  def initialize(xdo)
    @xdo = xdo
    @_xdo_pointer = xdo._pointer
  end
  
  # The XDo context that produced the window.
  attr_accessor :xdo
  
  # Types a string into the current window.
  def type_string(string, delay = 0.012)
    XDo::FFILib.xdo_type @_xdo_pointer, 0, string, (delay * 1_000_000).to_i
  end
  
  # Sends a keysequence to the active window.
  #
  # Examples: "alt+Return", "Alt_L+Tab", "l", "semicolon"
  def type_keysequence(keysequence, delay = 0.012)
    XDo::FFILib.xdo_keysequence @_xdo_pointer, 0, keysequence,
                                (delay * 1_000_000).to_i
  end
  
  # Presses a keysequence in the active window.
  #
  # Examples: "alt+Return", "Alt_L+Tab", "l", "semicolon"
  def press_keysequence(keysequence, delay = 0.012)
    XDo::FFILib.xdo_keysequence_down @_xdo_pointer, 0, keysequence,
                                     (delay * 1_000_000).to_i
  end
  
  # Releases a keysequence in the active window.
  #
  # Examples: "alt+Return", "Alt_L+Tab", "l", "semicolon"
  def release_keysequence(keysequence, delay = 0.012)
    XDo::FFILib.xdo_keysequence_up @_xdo_pointer, 0, keysequence,
                                   (delay * 1_000_000).to_i
  end
end  # class XDo::Keyboard

end  # namespace XDo
