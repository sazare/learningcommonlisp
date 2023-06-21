

(ql:quickload '(:ningle :clack))

(defvar *app* (make-instance 'ningle:<app>))

(setf (ningle:route *app* "/") "Welcome to ningle!")

(defun authorize (x y) t)

(setf (ningle:route *app* "/login" :method :POST)
      #'(lambda (params)
          (if (authorize (cdr (assoc "username" params :test #'string=))
                         (cdr (assoc "password" params :test #'string=)))
              "Authorized!"
              "Failed...Try again.")))

;; params'name sould be upper, string= ignore "name" as in doc of nigle 
(setf (ningle:route *app* "/hello/:name")
      #'(lambda (params)
          (format nil "Hello, ~A" (cdr (assoc "NAME" params :test #'string=)))))

(setf (ningle:route *app* "/hi" :accept '("text/html" "text/xml"))
      #'(lambda (params)
          (declare (ignore params))
          "<html><body>Hello, World!</body></html>"))


(defparameter *db* '(abc def ghi jkl mnn ozz))

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
  (format out "<html><head><title>sample</title></head>~%<body><h2>list test</h2>~a</body></html>" (mylist out body))
)

(setf (ningle:route *app* "/list" :accept '("text/html" "text/xml"))
      #'(lambda (params)
          (declare (ignore params))
          (apage nil *db*)
        )
)


(clack:clackup *app*)

