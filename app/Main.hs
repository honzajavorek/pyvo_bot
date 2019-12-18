module Main where

import System.Environment (getArgs)
import Lib

main :: IO ()
main = do
    name:_ <- getArgs
    someFunc name
