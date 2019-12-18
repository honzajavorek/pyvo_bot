module Lib
    ( someFunc
    ) where

someFunc :: String -> IO ()
someFunc name = putStrLn ("Hello " ++ name ++ "!")
