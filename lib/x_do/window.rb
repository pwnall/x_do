# :nodoc: namespace
class XDo

# Wraps an xdolib Window pointer.
class Window
  
  
  # Creates a wrapper for an X Window handle.
  #
  # This constructor is called internally by XDo#find_windows and client code
  # should not need to call it directly.
  #
  # Args:
  #   xdo:: the XDo wrapping the libxdo context used to get this Window
  #   _window:: the X Window handle to be wrapped
  def initialize(xdo, _window)
    @_xdo = xdo
    @_xdo_pointer = xdo._pointer
    @_window = _window
  end
end  # class XDo::Window

end  # namespace XDo
