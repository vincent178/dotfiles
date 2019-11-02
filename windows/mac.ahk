SetCapsLockState AlwaysOff

!x::
  IfWinActive, Hyper
    Send ^+x
  else 
    Send ^x
Return

!c::
  IfWinActive, Hyper
    Send ^+c
  else
    Send ^c
Return

!v::
  IfWinActive, Hyper
    Send ^+v
  else
    Send ^v
Return

CapsLock & b::Send {Left}
CapsLock & f::Send {Right}
CapsLock & p::Send {Up}
CapsLock & n::Send {Down}
CapsLock & a::Send {Home}
CapsLock & e::Send {End}

CapsLock & c::Send ^c
CapsLock & u::Send ^u
CapsLock & d::Send ^d
CapsLock & w::Send ^w
CapsLock & v::Send ^v

CapsLock & h::Send ^h
CapsLock & j::Send ^j
CapsLock & k::Send ^k
CapsLock & l::Send ^l

CapsLock & 1::Send ^1
CapsLock & 2::Send ^2
CapsLock & 3::Send ^3
CapsLock & 4::Send ^4
CapsLock & 5::Send ^5
CapsLock & 6::Send ^6
CapsLock & 7::Send ^7
CapsLock & 8::Send ^8
CapsLock & 9::Send ^9
CapsLock & 0::Send ^0

!n::Send ^n
!w::Send ^w
!t::Send ^t
!r::Send ^r
!s::Send ^s
!l::Send ^l
!a::Send ^a
!f::Send ^f
!z::Send ^z
