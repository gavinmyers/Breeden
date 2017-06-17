{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}


import Web.Scotty
import Network.Wai.Middleware.RequestLogger
import Data.Aeson (FromJSON, ToJSON)
import Data.Monoid ((<>))
import GHC.Generics

data Reading = Reading { temp :: Int } deriving (Show, Generic)
instance ToJSON Reading 
instance FromJSON Reading 

data Station = Station { stationId :: String, readings :: [Reading] } deriving (Show, Generic)
instance ToJSON Station
instance FromJSON Station 

data User = User { userId :: Int, userName :: String } deriving (Show, Generic)
instance ToJSON User
instance FromJSON User
obj :: User
obj = User { userId = 1, userName = "bob" }

main :: IO ()
main = scotty 3000 $ do
  middleware logStdoutDev
  post "/" $ do
    resp <- jsonData 
    json (resp :: Station) 

  get "/health" $ do
    text "UP"

  get "/:word" $ do
    beam <- param "word"
    html $ mconcat ["<h1>Gavin, ", beam, " me up!</h1>"]

