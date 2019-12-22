{-# LANGUAGE OverloadedStrings #-}

module Send
    ( telegram
    ) where

import Network.Wreq (get)
import qualified Data.Text as Text

telegram :: String -> String -> String -> IO ()
telegram apiKey chatId message = do
    let url = ("https://api.telegram.org/bot"
               ++ apiKey
               ++ "/sendMessage?chat_id="
               ++ chatId
               ++ "&parse_mode=Markdown&text="
               ++ message)
    _ <- get url
    return ()


