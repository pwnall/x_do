require 'ffi'

# :nodoc: namespace
class XDo

# :nodoc: function attachments
module FFILib
  attach_function :xdo_new, [:string], :pointer
  attach_function :xdo_version, [], :string
  attach_function :xdo_free, [:pointer], :void
  attach_function :xdo_window_search, [:pointer, :pointer, :pointer, :pointer],
                                      XDo::FFILib::Status
end  # module XDo::FFILib

end  # namespace XDo
