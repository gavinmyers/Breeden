(ns breeden.handler
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]))

(defroutes app-routes
  (GET "/" [] "Hello Gavin, this is the clojure webservice")
  (route/not-found "Not Found"))

(def app
  (wrap-defaults app-routes site-defaults))

