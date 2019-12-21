{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.Environment (getArgs)

import Calendar (parse)
import Fetch (fetch)

main :: IO ()
main = do
    ics <- fetch "https://pyvo.cz/api/series/praha-pyvo.ics"
    putStrLn . show $ parse ics

    -- name:_ <- getArgs
    -- someFunc name

-- https://api.telegram.org/bot{bot_token}/sendMessage?chat_id={chat}&parse_mode=Markdown&text={message}
