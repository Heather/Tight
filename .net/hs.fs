module Hs

open System
open System.Runtime.InteropServices

[<DllImport("ffi.dll", CallingConvention = CallingConvention.Cdecl)>]
extern void hs_init
   ( IntPtr argc
   , IntPtr argv)

[<DllImport("ffi.dll", CallingConvention = CallingConvention.Cdecl)>]
extern void hs_exit()

[<DllImport("ffi.dll", CallingConvention = CallingConvention.Cdecl)>]
extern int foo(string str)

printfn "Initializing runtime..."
hs_init(IntPtr.Zero, IntPtr.Zero)

try
  printfn "Calling to Haskell..."
  let result = foo("F#")
  printfn "Got result: %d" result
with
| _ as ex -> printfn "Error: %s" ex.Message
             hs_exit()
