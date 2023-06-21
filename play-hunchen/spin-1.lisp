; from https://github.com/ruricolist/spinneret 
;; dont work after A

(ql:quickload '("hunchentoot" "caveman2" "spinneret" "djula" "easy-routes"))

(in-package :spinneret)

 (defparameter *shopping-list*
   '("Atmospheric ponds"
     "Electric gumption socks"
     "Mrs. Leland's embyronic television combustion"
     "Savage gymnatic aggressors"
     "Pharmaceutical pianos"
     "Intravenous retribution champions"))

 (defparameter *user-name* "John Q. Lisper")

 (defparameter *last-login* "12th Never")

 (defmacro with-page ((&key title) &body body)
   `(with-html
      (:doctype)
      (:html
        (:head
         (:title ,title))
        (:body ,@body))))

 (defun shopping-list ()
   (with-page (:title "Home page")
     (:header
      (:h1 "Home page"))
     (:section
      ("~A, here is *your* shopping list: " *user-name*)
      (:ol (dolist (item *shopping-list*)
             (:li (1+ (random 10)) item))))
     (:footer ("Last login: ~A" *last-login*))))

; A
(in-package :spinneret)
(shopping-list)


