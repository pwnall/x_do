require 'ffi'

# :nodoc: namespace
class XDo

# FFI to the raw libxdo functions.
module FFILib
  extend FFI::Library
  ffi_lib 'libxdo.so'
  
  # :nodoc: lifted from xdo.h
  class XDoContext < FFI::Struct
    layout :xdpy, :pointer,
           :display_name, :string,
           :charcodes, :pointer,
           :charcodes_len, :int,
           :modmap, :pointer,
           :keymap, :pointer,
           :keycode_high, :int,
           :keycode_low, :int,
           :keysyms_per_keycode, :int,
           :close_display_when_freed, :int
  end  # class XDo::FFILib::XDoContext
  
  # :nodoc: lifted from xdo.h
  class XDoSearch < FFI::Struct
    layout :title, :string,
           :winclass, :string,
           :winclassname, :string,
           :winname, :string,
           :pid, :int,
           :max_depth, :long,
           :only_visible, :int,
           :screen, :int,
           :require, :int,
           :searchmask, :int,
           :desktop, :long
  end  # class XDo::FFILib::XDoSearch
  
  attach_function :xdo_new, [:string], :pointer
  attach_function :xdo_version, [], :string
  attach_function :xdo_free, [:pointer], :void
end  # module XDo::FFILib

end  # namespace XDo
