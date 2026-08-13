
(defun read-c-line (string)
  (with-input-from-string (stream string)
    (loop for object = (read stream nil nil)
    while object
    collect object)))

(defun readcfile (fname)
  (with-open-file (stream fname)
    (loop for line = (read-line stream nil nil)
      while line
      collect (read-c-line line))))

;; (readcfile "cset/ans1.txt")


