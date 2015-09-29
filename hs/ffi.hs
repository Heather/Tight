{-# LANGUAGE
    UnicodeSyntax
  , ForeignFunctionInterface
  #-}

module Foo where

import Foreign.C.String
import Foreign.C.Types

foreign import ccall unsafe "rust_hello" rust_hello :: CInt → IO CInt

foreign export ccall
  foo ∷ CString → IO CInt

foo ∷ CString → IO CInt
foo c_str = do
  str    ← peekCString c_str
  result ← hs_foo str
  v ← rust_hello $ fromIntegral result
  putStrLn ("Rust returned: " ++ show v)
  return $ v

hs_foo ∷ String → IO Int
hs_foo str = do
  putStrLn $ "Hello, " ++ str
  return (length str + 42)
