{-# LANGUAGE OverloadedStrings #-}

module Events
    ( parse
    , next
    , remaining
    , Event(Event, day, title)
    ) where

import qualified Data.Text as Text
import Data.Text.Read (decimal)
import Data.Time (Day, fromGregorianValid, diffDays)
import Data.List (minimumBy)
import Data.Function (on)

data Event = Event { day :: Day
                   , title :: Text.Text
                   } deriving (Eq, Ord, Show)

parse :: Text.Text -> [Event]
parse calendar = events
    where lines = Text.splitOn "\r\n" calendar
          (_, _, events) = foldl processLine (Nothing, Nothing, []) lines

processLine :: (Maybe Day, Maybe Text.Text, [Event]) -> Text.Text -> (Maybe Day, Maybe Text.Text, [Event])
processLine (day, title, events) line
    | "DTSTART:" `Text.isPrefixOf` line = ((parseDay line), title, events)
    | "SUMMARY:" `Text.isPrefixOf` line = (day, (parseTitle line), events)
    | line == "END:VEVENT"              = (Nothing, Nothing, (event day title):events)
    | otherwise                         = (day, title, events)

event :: Maybe Day -> Maybe Text.Text -> Event
event (Just day) (Just title) = Event { day = day, title = title }

parseDay :: Text.Text -> Maybe Day
parseDay line = fromGregorianValid y m d
    where (Just date) = Text.stripPrefix "DTSTART:" line
          (Right (y, _)) = decimal $ Text.take 4 date
          (Right (m, _)) = decimal $ Text.take 2 (Text.drop 4 date)
          (Right (d, _)) = decimal $ Text.take 2 (Text.drop 6 date)

parseTitle :: Text.Text -> Maybe Text.Text
parseTitle line = Just $ Text.replace "\\;" ";" value
    where (Just value) = Text.stripPrefix "SUMMARY:" line

next :: Day -> [Event] -> Event
next today events = minimumBy (compare `on` day) $ filter ((>= today) . day) events

remaining :: Day -> Event -> Integer
remaining today event = diffDays (day event) today
