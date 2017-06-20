(ns breeden.handler
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]
            [cheshire.core :refer :all] ))

(defn temperature [reading]
  (get reading "temp"))

(defn temperatures [readings]
  (map #(temperature %) readings))

(defn station [sid, stations] 
  (first (filter #(= (str (get % :stationId) sid)) stations)))

(defn average-temperature [station]
  (let [readings (get station "readings")]  
    (/ (apply + (temperatures readings)) (count readings)) ))


(defroutes app-routes
  (GET "/" [] "Hello Gavin, this is the clojure webservice")
  (POST "/:sid" {body :body params :params} 
    (let [station (station (get params :sid) (parse-string (slurp body)))]
      (pr-str (average-temperature station)) ))

  (route/not-found "Not Found"))

(def app (wrap-defaults app-routes (assoc-in site-defaults [:security :anti-forgery] false)))

