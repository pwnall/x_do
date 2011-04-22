require 'ffi'

# :nodoc: namespace
class XDo

# :nodoc: function attachments
module FFILib
  attach_function :xdo_new, [:string], :pointer
  attach_function :xdo_version, [], :string
  attach_function :xdo_free, [:pointer], :void
  attach_function :xdo_window_get_active, [:pointer, :pointer],
                                          XDo::FFILib::Status
  attach_function :xdo_window_get_focus, [:pointer, :pointer],
                                         XDo::FFILib::Status
  attach_function :xdo_window_sane_get_focus, [:pointer, :pointer],
                                              XDo::FFILib::Status

  attach_function :xdo_window_get_pid, [:pointer, :window], :int

  attach_function :xdo_window_search, [:pointer, :pointer, :pointer, :pointer],
                                      XDo::FFILib::Status

  attach_function :xdo_window_activate, [:pointer, :window], XDo::FFILib::Status
  attach_function :xdo_window_focus, [:pointer, :window], XDo::FFILib::Status
  attach_function :xdo_window_raise, [:pointer, :window], XDo::FFILib::Status
                                     
  attach_function :xdo_get_window_location, [:pointer, :window, :pointer,
                                             :pointer, :pointer],
                                            XDo::FFILib::Status
  attach_function :xdo_get_window_size, [:pointer, :window, :pointer, :pointer],
                                        XDo::FFILib::Status
  attach_function :xdo_window_move, [:pointer, :window, :int, :int],
                                    XDo::FFILib::Status
  attach_function :xdo_window_setsize, [:pointer, :window, :int, :int, :int],
                                       XDo::FFILib::Status
end  # module XDo::FFILib

end  # namespace XDo
