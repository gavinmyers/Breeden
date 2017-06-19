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

(defroutes app-routes
  (GET "/" [] "Hello Gavin, this is the clojure webservice")
  (POST "/:sid" {body :body params :params} 
    (pr-str (apply + (temperatures (get (station (get params :sid) (parse-string (slurp body))) "readings")))))

  (route/not-found "Not Found"))

(def app (wrap-defaults app-routes (assoc-in site-defaults [:security :anti-forgery] false)))

