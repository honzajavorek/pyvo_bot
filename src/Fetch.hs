{-# LANGUAGE OverloadedStrings #-}

module Fetch
    ( fetch
    ) where

import qualified Data.Text as Text
import Network.Wreq (get, responseBody, Response)
import Control.Lens ((^.))
import Data.ByteString.Lazy (ByteString)
import Data.Text.Lazy (toStrict)
import Data.Text.Lazy.Encoding (decodeUtf8)

fetch :: String -> IO Text.Text
fetch url = do
    response <- get url
    return $ body response

body :: Response ByteString -> Text.Text
body response = toStrict . decodeUtf8 $ response ^. responseBody
