{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Network.Wai.Middleware.RequestLogger

main :: IO ()
main = scotty 3000 $ do
  middleware logStdoutDev
  get "/:word" $ do
    beam <- param "word"
    html $ mconcat ["<h1>Gavin, ", beam, " me up!</h1>"]

  get "/health" $ do
    text "UP"
