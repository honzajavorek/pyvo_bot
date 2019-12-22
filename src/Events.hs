{-# LANGUAGE OverloadedStrings #-}

module Events
    ( parse
    ) where

import qualified Data.Text as Text
import Data.Text.Read (decimal)
import Data.Time (Day, fromGregorianValid)

data Event = Event { day :: Day
                   , name :: Text.Text
                   } deriving (Eq, Ord, Show)

parse :: Text.Text -> [Event]
parse calendar = events
    where lines = Text.splitOn "\r\n" calendar
          (_, _, events) = foldl processLine (Nothing, Nothing, []) lines

processLine :: (Maybe Day, Maybe Text.Text, [Event]) -> Text.Text -> (Maybe Day, Maybe Text.Text, [Event])
processLine (day, name, events) line
    | "DTSTART:" `Text.isPrefixOf` line = ((parseDay line), name, events)
    | "SUMMARY:" `Text.isPrefixOf` line = (day, (parseName line), events)
    | line == "END:VEVENT"              = (Nothing, Nothing, (event day name):events)
    | otherwise                         = (day, name, events)

event :: Maybe Day -> Maybe Text.Text -> Event
event (Just day) (Just name) = Event { day = day, name = name }

parseDay :: Text.Text -> Maybe Day
parseDay line = fromGregorianValid y m d
    where (Just date) = Text.stripPrefix "DTSTART:" line
          (Right (y, _)) = decimal $ Text.take 4 date
          (Right (m, _)) = decimal $ Text.take 2 (Text.drop 4 date)
          (Right (d, _)) = decimal $ Text.take 2 (Text.drop 6 date)

parseName :: Text.Text -> Maybe Text.Text
parseName = Text.stripPrefix "SUMMARY:"
