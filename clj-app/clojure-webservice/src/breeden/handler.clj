(ns breeden.handler
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]
            [cheshire.core :refer :all] ))

(defn numbers [coll] 
  (filter number? coll))

(defn avg [coll]
  (/ (reduce + (numbers coll)) (max (count (numbers coll)) 1)))

(defn get-speed [nodes] 
  (avg (map read-string (map #(get % :SPD) nodes))))

(defn parse-body [body] 
  (map #(get-speed (val %)) (parse-string (slurp body) true)))

(defroutes app-routes
  (GET "/" [] "Hello Gavin, this is the clojure webservice")
  (POST "/" {body :body} (pr-str (parse-body body)))
  (POST "/:sid" {body :body params :params} (str (get params :sid) (pr-str params) (pr-str (parse-string (slurp body)))))

  (route/not-found "Not Found"))

(def app (wrap-defaults app-routes (assoc-in site-defaults [:security :anti-forgery] false)))

