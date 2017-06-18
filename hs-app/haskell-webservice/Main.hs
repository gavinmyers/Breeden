{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

import Web.Scotty
import Network.Wai.Middleware.RequestLogger
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics

data Reading = Reading { temp :: Int } deriving (Show, Generic)
instance ToJSON Reading 
instance FromJSON Reading 

data Station = Station { stationId :: String, readings :: [Reading] } deriving (Show, Generic)
instance ToJSON Station
instance FromJSON Station 

hasStation :: String -> [Station] -> [Station] 
hasStation sid stations = filter (\station -> stationId station == sid) stations 

main :: IO ()
main = scotty 3000 $ do
  middleware logStdoutDev
  post "/" $ do
    resp <- jsonData 
    json (resp :: [Station]) 

  post "/:station" $ do
    resp <- jsonData 
    sid <- param "station"
    json (hasStation sid resp)

  get "/health" $ do
    text "UP"

  get "/:word" $ do
    beam <- param "word"
    html $ mconcat ["<h1>Gavin, ", beam, " me up!</h1>"]

