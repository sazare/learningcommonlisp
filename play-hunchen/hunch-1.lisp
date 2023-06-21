(ql:quickload '("hunchentoot" "caveman2" "spinneret" "djula" "easy-routes"))

(defvar *acceptor* (make-instance 'hunchentoot:easy-acceptor :port 4344))

(hunchentoot:start *acceptor*)

;(defparameter *message* "first message")

;; web home /Users/shin/quicklisp/dists/quicklisp/software/hunchentoot-v1.3.0/www/
;; http://127.0.0.1:4343/ show www/index.html

;; exist /Users/shin/quicklisp/dists/quicklisp/software/hunchentoot-v1.3.0/www/web/index.html
;; then you can see http://127.0.0.1:4343/web/index.html

;;; www in here is a ln-s of the home

;; ln -s /Users/shin/quicklisp/dists/quicklisp/software/hunchentoot-v1.3.0/www .

;(defparameter *message* "next")

;;;; (hunchentoot:stop *acceptor*)


