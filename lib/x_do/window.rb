# :nodoc: namespace
class XDo

# Wraps an xdolib Window pointer.
class Window
  # Brings a window forward and gives it focus.
  def activate
    XDo::FFILib.xdo_window_activate @_xdo_pointer, @_window
  end
  
  # Gives the input focus to a window
  def focus
    XDo::FFILib.xdo_window_focus @_xdo_pointer, @_window
  end

  # Moves the window at the top of the stack, making it visible.
  def raise
    XDo::FFILib.xdo_window_raise @_xdo_pointer, @_window
  end
  
  # The PID of the process owning the window.
  def pid
    XDo::FFILib.xdo_window_get_pid @_xdo_pointer, @_window
  end
  
  # Creates a wrapper for an X Window handle.
  #
  # This constructor is called internally by XDo#find_windows and client code
  # should not need to call it directly.
  #
  # Args:
  #   xdo:: the XDo wrapping the libxdo context used to get this Window
  #   _window:: the X Window handle to be wrapped
  def initialize(xdo, _window)
    @xdo = xdo
    @_xdo_pointer = xdo._pointer
    @_window = _window
  end
  
  # The XDo context that produced the window.
  attr_accessor :xdo
  
  # The underlying X Window handle.
  attr_accessor :_window

  # :nodoc: underlying window handle should impact equality
  def ==(other)
    other.kind_of?(XDo::Window) && @_window == other._window
  end
  
  # :nodoc: override hash to match ==
  def hash
    _window.hash
  end
end  # class XDo::Window

end  # namespace XDo
