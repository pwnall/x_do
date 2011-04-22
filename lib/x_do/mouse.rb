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
    old_location = self.location
    move_async x, y, screen
    unless old_location[0, 2] == [x, y]
      wait_for_move_from old_location[0], old_location[1]
    end
  end

  # Queues a mouse move request to the X server.
  def move_async(x, y, screen)
    XDo::FFILib.xdo_mousemove @_xdo_pointer, x, y, screen
  end

  # Moves the mouse relatively to its current position.
  def move_relative(dx, dy)
    old_location = self.location
    move_relative_async dx, dy
    unless dx == 0 && dy == 0
      wait_for_move_from old_location[0], old_location[1]
    end
  end

  # Queues a mouse move request to the X server.
  def move_relative_async(dx, dy)
    XDo::FFILib.xdo_mousemove_relative @_xdo_pointer, dx, dy
  end

  # Blocks until the mouse moves away from a position on screen.
  def wait_for_move_from(x, y)
    XDo::FFILib.xdo_mouse_wait_for_move_from @_xdo_pointer, x, y
  end
  
  # Blocks until the mouse moves to a position on screen.
  def wait_for_move_to(x, y)
    XDo::FFILib.xdo_mouse_wait_for_move_to @_xdo_pointer, x, y
  end
  
  # Clicks a mouse button.
  def click(button)
    XDo::FFILib.xdo_click @_xdo_pointer, 0, button
  end

  # Presses a mouse button.
  def press(button)
    XDo::FFILib.xdo_mousedown @_xdo_pointer, 0, button
  end

  # Releases a mouse button.
  def release(button)
    XDo::FFILib.xdo_mouseup @_xdo_pointer, 0, button
  end
end  # class XDo::Mouse

end  # namespace XDo
