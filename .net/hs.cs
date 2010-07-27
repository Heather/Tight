using System;
using System.Runtime.InteropServices;

//Test Haskell FFI
namespace Foo {
    class MainClass {
        [DllImport("ffi.dll", CallingConvention = CallingConvention.Cdecl)]
        private static extern void hs_init(IntPtr argc, IntPtr argv);

        [DllImport("ffi.dll", CallingConvention = CallingConvention.Cdecl)]
        private static extern void hs_exit();

        [DllImport("ffi.dll", CallingConvention = CallingConvention.Cdecl)]
        private static extern int foo(string str);

        public static void Main(string[] args) {
            Console.WriteLine("Initializing runtime...");
            hs_init(IntPtr.Zero, IntPtr.Zero);

            try {
                Console.WriteLine("Calling to Haskell...");
                int result = foo("C#");
                Console.WriteLine("Got result: {0}", result);
            } finally {
                Console.WriteLine("Exiting runtime...");
                hs_exit();
            }
        }
    }
}
