(ql:quickload '("hunchentoot" "caveman2" "spinneret" "djula" "easy-routes"))


;;"/Users/shin/Projects/github/learningcommonlisp/clark")

(defvar *myacceptor* (make-instance 'hunchentoot:easy-acceptor :port 4344))

(setf (hunchentoot:acceptor-document-root *myacceptor*) #p"/Users/shin/Projects/github/learningcommonlisp/play-hunchen/www")

(defparameter *myname* "omura")

(hunchentoot:start *myacceptor*)

;; web home /Users/shin/quicklisp/dists/quicklisp/software/hunchentoot-v1.3.0/www/
;; http://127.0.0.1:4344/www/ show www/index.html

;; exist /Users/shin/quicklisp/dists/quicklisp/software/hunchentoot-v1.3.0/www/web/index.html
;;; then see  http://127.0.0.1:4344/www/web/index.html

;;; if dont setf change acceptor-document-root, no www in www/index.html or www/web/index.html

;;; !! index.html must be written


(defun hello ()
   (format nil "Hello, ~a" *myname*)
)

(hunchentoot:stop *myacceptor*)
(hunchentoot:start *myacceptor*)

(push
  (hunchentoot:create-prefix-dispatcher "/hellome.html" #'hello)
  hunchentoot:*dispatch-table*)

;; http://127.0.0.1:4344/hellome.html

(hunchentoot:stop *myacceptor*)
(hunchentoot:start *myacceptor*)

(hunchentoot:define-easy-handler (say-yo :uri "/lolo") (name)
  (setf (hunchentoot:content-type*) "text/plain")
  (format nil "Hey~@[ ~A~]!" name))

;; http://127.0.0.1:4344/lolo
;; http://127.0.0.1:4344/lolo?name=commonlisp


;;;; (hunchentoot:stop *myacceptor*)




