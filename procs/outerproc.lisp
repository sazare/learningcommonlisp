;; inter process communication

(load "procs-package.lisp")
(in-package :procloop)

(defun create-olog (logfile)
  (unless (probe-file logfile)
     (with-open-file (out logfile
                   :direction :output
                   :if-exists :supersede)
     )
  )
)

(defun outsider (gi ofile)
  (prog (cmd r (logf #p"olog3"))
    (create-olog logf)
    (setq cmd (with-output-to-string (out)
      (format out "sbcl --script innerproc.lisp  ~a '~a'" gi ofile)))
    (format t "cmd = ~a~%" cmd)
    (setq r (uiop:run-program cmd :output logf :IF-OUTPUT-EXISTS :append :force-output t))
    (return r)
  )
)

;;; --scriptはreplしない。--loadは普通の動きになるのでpromptがでたりする
;; logとるつもりなら--loadがよいかも。
;;実行するだけなら--scriptがよいようだ
; (format out "sbcl --script innerproc.lisp  ~a '~a'" gi ofile)))
; (format out "sbcl --load innerproc.lisp  ~a '~a'" gi ofile)))

