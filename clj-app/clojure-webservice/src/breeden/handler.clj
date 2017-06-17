(ns breeden.handler
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]
            [cheshire.core :refer :all] ))

(defroutes app-routes
  (GET "/" [] "Hello Gavin, this is the clojure webservice")
  (POST "/" {body :body} (str  (keys (parse-string (slurp body) true))))
  (route/not-found "Not Found"))


(def app (wrap-defaults app-routes (assoc-in site-defaults [:security :anti-forgery] false)))

