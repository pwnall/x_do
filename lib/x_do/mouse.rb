# :nodoc: namespace
class XDo

# The mouse state for a libxdo context.
class Mouse
  # Creates a mouse state wrapper for an XDo context.
  #
  # This constructor is called internally by XDo#mouse and client code
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
  
  # [x, y, screen] array of mouse coordinates.
  def location
    x_pointer = FFI::MemoryPointer.new :int, 1
    y_pointer = FFI::MemoryPointer.new :int, 1
    screen_pointer = FFI::MemoryPointer.new :int, 1
    XDo::FFILib.xdo_mouselocation @_xdo_pointer, x_pointer, y_pointer,
                                  screen_pointer
    [x_pointer.read_int, y_pointer.read_int, screen_pointer.read_int]
  end
  
  # Moves the mouse to a new position.
  def move(x, y, screen)
    XDo::FFILib.xdo_mousemove @_xdo_pointer, x, y, screen
  end
end  # class XDo::Mouse

end  # namespace XDo
