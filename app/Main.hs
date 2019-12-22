{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.Environment (getArgs, getEnv)
import Data.Time (getCurrentTime, utctDay)
import qualified Data.Text as Text

import Events (parse, next, remaining)
import Fetch (fetch)
import Format (formatEvent, formatRemainingDays)
import Send (telegram)

main :: IO ()
main = do
    url:_ <- getArgs
    ics <- fetch url
    time <- getCurrentTime

    let today = utctDay time
        event = next today $ parse ics
        eventStr = formatEvent event
        days = remaining today event
        maybeDaysStr = formatRemainingDays days

    putStrLn ("Next Pyvo: " ++ eventStr)
    putStrLn ("Days remaining: " ++ (show days))

    if maybeDaysStr == Nothing
        then return ()
        else do
            let (Just daysStr) = maybeDaysStr
            putStrLn daysStr

            apiKey <- getEnv "TELEGRAM_API_KEY"
            chatId <- getEnv "TELEGRAM_CHAT_ID"
            telegram apiKey chatId (daysStr ++ " " ++ eventStr)
