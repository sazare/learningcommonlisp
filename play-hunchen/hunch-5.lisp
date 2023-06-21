;;; dont work ??

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


(defparameter *keyvalue* "find")

(defun genlist (name)
  (loop for x from 1 to 5 collect
    name
  )
)

(defun mylist (out names)
  (let (fs)
    (setq fs "<ol>")
    (loop for name in names do
      (setq fs (format nil "~a~%~a" fs (format out "<li>~a</li>" name)))
    )
    (format out (format nil "~a~%~a" fs "</ol>"))
  )
)

(defun apage (out body)
  (format out "<!DOCTYPE html>~%<html>~%<head><title>sample</title></head>~%<body>~a</body></html>" (mylist out body))
)

(hunchentoot:define-easy-handler (say-yo :uri "/apropos") (value)
  (let ()
    (setf (hunchentoot:content-type*) "text/plain")
    (apage nil (genlist value))
  )
)

;;(hunchentoot:define-easy-handler (easy-test :uri "/mytest") (value)
;;
;;)

;; http://127.0.0.1:4444/apropos
;; http://127.0.0.1:4444/apropos?name=list

;;;; (hunchentoot:stop *myacceptor*)


