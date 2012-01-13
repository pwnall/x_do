# Context for automation actions.
class XDo
  # Creates a context for an X display.
  #
  # Args:
  #   display_name:: an X display name, such as ":0"; if not given, libxdo will
  #                  choose a default display (usually the one pointed by the
  #                  DISPLAY variable)
  def initialize(display_name = nil)
    @_pointer = XDo::FFILib.xdo_new display_name
    @_context = XDo::FFILib::XDoContext.new @_pointer
    @keyboard = XDo::Keyboard.new self
    @mouse = XDo::Mouse.new self
  end
  
  # Releases resources associated with this context.
  def close
    return unless @_context
    XDo::FFILib.xdo_free @_pointer
    @_pointer = nil
    @_context = nil
  end
  
  # :nodoc: automatically close contexts as they go out of scope.
  def finalize
    close
  end
  
  # The display name for the current context.
  def display_name
    @_context[:display_name]
  end
  
  # The underlying libxdo context structure.
  attr_accessor :_context
  # Pointer to the underlying _libxdo context structure.
  attr_accessor :_pointer
  
  # The keyboard state for this context.
  attr_accessor :keyboard

  # The mouse state for this context.
  attr_accessor :mouse
  
  # Returns X windows matching a query.
  #
  # Args:
  #   options:: hash that accepts the following keys:
  #     :title:: grep pattern that the window title has to match
  #     :name:: grep pattern that the window name has to match
  #     :class:: grep pattern that the window class has to match
  #     :class_name:: grep pattern that the window class (name?) has to match
  #     :pid:: only return windows whose process ID equals this
  #     :screen:: only return windows in this screen number
  #     :desktop:: only return windows with this desktop number
  #     :visible:: if true, only visible windows will be returned
  #
  # Returns an array of Window instances that match the query.
  def find_windows(options = {})
    query = XDo::FFILib::XDoSearch.from_options options
    windows_pointer = FFI::MemoryPointer.new :pointer, 1
    count_pointer = FFI::MemoryPointer.new :ulong, 1
    XDo::FFILib.xdo_window_search @_pointer, query, windows_pointer,
                                  count_pointer
    count = count_pointer.read_ulong
    windows = windows_pointer.read_pointer.read_array_of_long(count)
    windows.map { |window| XDo::Window.new self, window }
  end
  
  # Returns the currently active X window.
  def active_window
    window_pointer = FFI::MemoryPointer.new :ulong, 1
    XDo::FFILib.xdo_window_get_active @_pointer, window_pointer
    XDo::Window.new self, window_pointer.read_ulong
  end
  
  # Returns the X window that has the input focus.
  def focused_window
    window_pointer = FFI::MemoryPointer.new :ulong, 1
    XDo::FFILib.xdo_window_get_focus @_pointer, window_pointer
    XDo::Window.new self, window_pointer.read_ulong
  end

  # Returns the "real" X window that has the input focus.
  #
  # This calls xdo_window_sane_get_focus instead of xdo_window_get_focus and is
  # recommended.
  def real_focused_window
    window_pointer = FFI::MemoryPointer.new :ulong, 1
    XDo::FFILib.xdo_window_sane_get_focus @_pointer, window_pointer
    XDo::Window.new self, window_pointer.read_ulong
  end
  
  # The version of the underlying library.
  #
  # This method is mostly useful as a health check on your installtion. A
  # non-nil, non-empty result means the gem was built successfully against
  # libxdo.
  def self.lib_version
    XDo::FFILib.xdo_version
  end
end  # class XDo
