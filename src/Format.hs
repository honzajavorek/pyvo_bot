{-# LANGUAGE OverloadedStrings #-}

module Format
    ( formatEvent
    , formatRemainingDays
    ) where

import Data.Time (Day, toGregorian)
import qualified Data.Text as Text

import Events (Event(Event, day, title))

formatEvent :: Event -> String
formatEvent (Event { day = d, title = t }) = ((formatDay d) ++ " — " ++ (Text.unpack t))

formatDay :: Day -> String
formatDay day = (dStr ++ ". " ++ mStr ++ ".")
    where (y, m, d) = toGregorian $ day
          mStr = show m
          dStr = show d

formatRemainingDays :: Integer -> Maybe String
formatRemainingDays 0 = Just "Tonight!"
formatRemainingDays 1 = Just "Tomorrow!"
formatRemainingDays 7 = Just "Next week!"
formatRemainingDays _ = Nothing
