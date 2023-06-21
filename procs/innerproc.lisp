;; inter process communication

(load "procs-package.lisp")

(in-package :procloop)

;; inside
; mujun-prover is called in another process by run-program
(defun insider ()
  (let (sexp gi ofile)
    (setq sexp sb-ext:*posix-argv*)
       (format t "inner: ~a~%" sexp)
    (setq gi (parse-integer (nth 1 sexp)))
    (setq ofile (nth 2 sexp))

    (format t "inner: gi=~a, ofile=~a~%" gi ofile)
    23   
  )
)

(insider )

