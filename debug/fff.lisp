(defun fact (x) 
  (cond
    ((eq x 0) 1)
    (t (* x (fact (- x 1))))
  )
)
