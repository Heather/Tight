{-# LANGUAGE
    OverloadedStrings
  , UnicodeSyntax
  #-}

module Foo where

import Foreign.C.String
import Foreign.C.Types

foreign export ccall
  foo ∷ CString → IO CInt

foo ∷ CString → IO CInt
foo c_str = do
  str    ← peekCString c_str
  result ← hs_foo str
  return $ fromIntegral result

hs_foo ∷ String → IO Int
hs_foo str = do
  putStrLn $ "Hello, " ++ str
  return (length str + 42)
