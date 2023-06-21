

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

(clack:clackup *app*)

