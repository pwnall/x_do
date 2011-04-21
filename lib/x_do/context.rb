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
  
  # The version of the underlying library.
  #
  # This method is mostly useful as a health check on your installtion. A
  # non-nil, non-empty result means the gem was built successfully against
  # libxdo.
  def self.lib_version
    XDo::FFILib.xdo_version
  end
end  # class XDo
