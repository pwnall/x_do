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
  
  # [x, y] array containing the window's coordinates.
  def location
    x_pointer = FFI::MemoryPointer.new :int, 1
    y_pointer = FFI::MemoryPointer.new :int, 1
    XDo::FFILib.xdo_get_window_location @_xdo_pointer, @_window, x_pointer,
                                        y_pointer, nil
    [x_pointer.read_int, y_pointer.read_int]
  end
  
  # [width, height] array containing the window's size.
  def size
    width_pointer = FFI::MemoryPointer.new :int, 1
    height_pointer = FFI::MemoryPointer.new :int, 1
    XDo::FFILib.xdo_get_window_size @_xdo_pointer, @_window, width_pointer,
                                    height_pointer
    [width_pointer.read_int, height_pointer.read_int]
  end

  def move(x, y)
    move_raw x, y
    glitched_location = self.location
    x_decoration = glitched_location.first - x
    y_decoration = glitched_location.last - y
    move_raw x - x_decoration, y - y_decoration
  end
  
  # Moves this window to a new position.
  #
  # The position is given directly to X, and does not account for window
  # decorations.
  def move_raw(x, y)
    old_location = self.location
    return_value = move_raw_async x, y
    100.times do
      break unless self.location == old_location
      sleep 0.01
    end
    return_value
  end
  
  # Asks X to move this window to a new position.
  def move_raw_async(x, y)
    XDo::FFILib.xdo_window_move @_xdo_pointer, @_window, x, y
  end
  
  # Resizes this window.
  #
  # Args:
  #   width:: the new window's width
  #   height:: the new window's height
  #   use_hints:: if false, width and height are specified in pixels; otherwise,
  #               the unit is relative to window size hints
  def resize(width, height, use_hints = false)
    old_size = self.size
    return_value = resize_async width, height, use_hints
    100.times do
      break unless self.size == old_size
      sleep 0.01
    end
    return_value
  end
  
  # Asks X to resize this window.
  def resize_async(width, height, use_hints = false)
    flags = use_hints ? XDo::FFILib::Consts::SIZE_U : 0
    XDo::FFILib.xdo_window_setsize @_xdo_pointer, @_window, width, height, flags
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
