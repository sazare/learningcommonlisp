
(ql:quickload '("hunchentoot" "caveman2" "spinneret" "djula" "easy-routes"))

;;"/Users/shin/Projects/github/learningcommonlisp/clark")

;; (defparameter *port* 4444) dont work

(defparameter *myacceptor* (make-instance 'hunchentoot:easy-acceptor :port 4444))

(setf (hunchentoot:acceptor-document-root *myacceptor*) #p"/Users/shin/Projects/github/learningcommonlisp/play-hunchen/www")

(defparameter *myname* "shinichi")

(hunchentoot:start *myacceptor*)

;; web home /Users/shin/quicklisp/dists/quicklisp/software/hunchentoot-v1.3.0/www/
;; http://127.0.0.1:4444/www/ show www/index.html

;; exist /Users/shin/quicklisp/dists/quicklisp/software/hunchentoot-v1.3.0/www/web/index.html
;;; then see  http://127.0.0.1:4444/www/web/index.html

;;; if dont setf change acceptor-document-root, no www in www/index.html or www/web/index.html

;;; !! index.html must be written


(defun hello ()
   (format nil "Hello, ~a" *myname*)
)


(push
  (hunchentoot:create-prefix-dispatcher "/hellome.html" #'hello)
  hunchentoot:*dispatch-table*)

;; http://127.0.0.1:4444/hellome.html


(hunchentoot:define-easy-handler (say-yo :uri "/lolo5") (name)
  (setf (hunchentoot:content-type*) "text/plain")
  (format nil "Hey~@[ ~A~]!" name))


;; http://127.0.0.1:4444/loloi5
;; http://127.0.0.1:4444/lolo5?name=commonlisp

;(defparameter *keyvalue* "find")
;
;(hunchentoot:define-easy-handler (say-yo :uri "/apropos") (name)
;  (setf (hunchentoot:content-type*) "text/plain")
;  (format nil "Hey~@[ ~A~]!" (apropos *keyvalue*)))

;; http://127.0.0.1:4444/apropos
;; http://127.0.0.1:4444/apropos?name=list

;;;; (hunchentoot:stop *myacceptor*)



