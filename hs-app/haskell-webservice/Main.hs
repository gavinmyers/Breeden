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

temperature :: Reading -> Int
temperature r = temp r

temperatures :: [Reading] -> [Int]
temperatures rs = map temperature rs

station :: String -> [Station] -> Station 
station sid stations = head (filter (\station -> stationId station == sid) stations) 

average_temperature :: Station -> Int 
average_temperature st = do 
  let tps =  temperatures $ readings st
      s = sum tps
      l = length tps
  div s l 

main :: IO ()
main = scotty 3000 $ do
  middleware logStdoutDev
  post "/" $ do 
    resp <- jsonData 
    json (resp :: [Station])  

  post "/:station" $ do
    resp <- jsonData 
    sid <- param "station"
    json $ average_temperature $ station sid resp

  get "/:word" $ do
    w <- param "word"
    html $ mconcat ["<h1>Gavin, ", w, " is the word!</h1>"]

