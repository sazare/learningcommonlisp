
(defparameter c95 (loop for d from 0 to 94 collect (code-char (+ 32 d))))

(defun rando (W H)
  (loop for j from 1 to H do 
    (loop for i from 1 to W do 
      (format t "~c" (nth (random 95) c95)))
    (format t "~%")
  )
)


;(rando 60 30)

;;;

(defun randl (cs N)
  (let ((nc (1-  (length cs))))
    (loop for i from 1 to N collect 
      (nth (random nc) cs)
    )
  )
)

(defparameter c1000 (randl c95 1000))

(defun showc (cs) 
  (loop for c in cs do
    (format t "~c" c)
  )
)

