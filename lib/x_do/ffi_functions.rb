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
                                     
  attach_function :xdo_get_window_name, [:pointer, :window, :pointer, :pointer, 
                                         :pointer], XDo::FFILib::Status
  attach_function :xdo_get_window_location, [:pointer, :window, :pointer,
                                             :pointer, :pointer],
                                            XDo::FFILib::Status
  attach_function :xdo_get_window_size, [:pointer, :window, :pointer, :pointer],
                                        XDo::FFILib::Status
  attach_function :xdo_window_move, [:pointer, :window, :int, :int],
                                    XDo::FFILib::Status
  attach_function :xdo_window_setsize, [:pointer, :window, :int, :int, :int],
                                       XDo::FFILib::Status
  attach_function :xdo_mouselocation, [:pointer, :pointer, :pointer, :pointer],
                                      XDo::FFILib::Status
  attach_function :xdo_mousemove, [:pointer, :int, :int, :int],
                                  XDo::FFILib::Status
  attach_function :xdo_mousemove_relative, [:pointer, :int, :int],
                                           XDo::FFILib::Status
  attach_function :xdo_mouse_wait_for_move_from, [:pointer, :int, :int],
                                                 XDo::FFILib::Status
  attach_function :xdo_mouse_wait_for_move_to, [:pointer, :int, :int],
                                               XDo::FFILib::Status
  
  attach_function :xdo_mousemove_relative_to_window, [:pointer, :window, :int,
                                                      :int], XDo::FFILib::Status
  attach_function :xdo_mousedown, [:pointer, :window, :int], XDo::FFILib::Status
  attach_function :xdo_mouseup, [:pointer, :window, :int], XDo::FFILib::Status
  attach_function :xdo_click, [:pointer, :window, :int], XDo::FFILib::Status

  attach_function :xdo_type, [:pointer, :window, :string, :int],
                             XDo::FFILib::Status
  attach_function :xdo_keysequence, [:pointer, :window, :string, :int],
                                    XDo::FFILib::Status
  attach_function :xdo_keysequence_down, [:pointer, :window, :string, :int],
                                         XDo::FFILib::Status
  attach_function :xdo_keysequence_up, [:pointer, :window, :string, :int],
                                       XDo::FFILib::Status
end  # module XDo::FFILib

end  # namespace XDo
