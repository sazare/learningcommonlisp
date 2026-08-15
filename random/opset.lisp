
(defun read-char-from-string (string)
  (with-input-from-string (stream string)
    (loop for object = (read-char stream nil nil)
    while object
    collect object)))

(defun write-cs-to-file (clist file)
  (with-open-file (out file
    :direction :output
    :if-exists :supersede)
    (loop for c in clist do
      (format out "~c" c)
    )
  )
)

;;
(defun make-sheet (clist len)
  (let ((cnum (length clist)))
    (loop for i from 1 to len collect
      (nth (random cnum) clist)
    )
  )
)

; (defparameter yyy (read-char-from-string "abcdeABC"))
; (setq zz (make-sheet clist 1000)
; (write-cs-to-file zz "zz.sheet")
;;


(defun read-char-file (fname)
  (with-open-file (stream fname)
    (loop for c = (read-char stream nil nil)
      until (or (null c) (equal c #\Newline))
      collect c)
  )
)


;; (read-char-file "cset/ans1.txt")


(defun gen-sheet (csetfile len sname)
  (let (cs sheet)
    (setq cs (read-char-file csetfile))
    (setq sheet (make-sheet cs len))
    (write-cs-to-file sheet sname)
  )
)

(defun run-gen-sheet ()
  (gen-sheet "cset/a.txt" 100 "a.100")
)

;;;;

(defun gpwd (sname len)
  (let (slen sheet spos)
    (setq sheet (read-char-file sname))
    (setq slen (length sheet))
    (setq spos (random (- slen len)))
    (list sname spos len)
  )
)

(defun ppwd (sname spos len)
  (let (sheet )
    (setq sheet (read-char-file sname))
    (loop for p from spos to (1- (+ spos len)) do
      (format t "~c" (nth p sheet))
    )
  )
)
 
;;;; sample
(defun samplerun () ;;; dontrun
   (gen-sheet "cset/ans1.txt" 2000 "sheets/test1.s")
   (gpwd "sheets/test1.s" 25 )
; ("sheets/test1.s" 1346 25)
   (ppwd "sheets/test1.s" 1346 25)
)

