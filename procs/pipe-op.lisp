
(defconstant eod "EOD")

(defun snd-p (f)
  (with-open-file (out F
                       :direction :output
                       :if-exists :append)
    (loop for x from 0 to 4 do 
      (format out "no.~a~%" x)
    )
    (format out "~a~%" eod)
  )
)

(defun rcv-p (f)
  (with-open-file (ins f )
    (let (data)
      (loop until (equal eod (setf data (read-line ins) ))
       collect
          (let () 
             (format t "~a~%" data)
            data
          )
      )
    )
  )
)

