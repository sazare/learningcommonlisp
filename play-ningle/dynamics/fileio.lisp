;; 
;; from rubbish-kqcio.lisp

(defun readafile (fname)
 (with-open-file (ins fname)
   (let (data)
     (loop until (eq :eof (setf data (read ins nil :eof)))
       collect
          data
       )
     )
 )
)


(defun file-at-once (filespec &rest open-args)
  (with-open-stream (stream (apply #'open filespec open-args))
    (let* ((buffer (make-array (file-length stream)
                  :element-type
                  (stream-element-type stream)
                  :fill-pointer t))
                    (position (read-sequence buffer stream)))
     (setf (fill-pointer buffer) position)
                   buffer))
)

