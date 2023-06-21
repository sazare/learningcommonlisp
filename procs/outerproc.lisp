;; inter process communication

(load "procs-package.lisp")
(in-package :procloop)

(defun outsider (gi ofile)
  (prog (cmd r)
    (setq cmd (with-output-to-string (out)
      (format out "sbcl --script innerproc.lisp  ~a '~a'" gi ofile)))
    (format t "cmd = ~a~%" cmd)
    (setq r (uiop:run-program cmd  :output "olog2" :IF-OUTPUT-EXISTS :supersede :force-output t))
    (return r)
  )
)

