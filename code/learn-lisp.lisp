Commonlisp CD DB
(myload "load-ito.lisp")

(defvar *vvv* nil)
(defun add-me (me) (push me *vvv*))
(defun make-me (name age)
  (list :name name :age age))

(add-me (make-me "shin" 64))
*vvv*

;; assoc list
(defvar *sss* nil)

(ito-set "assoc"
  (setf *sss* (pairlis '(a b c) '(1 2 3)))
  (intend-equal "test for assoc value" '(b . 2) (assoc 'b *sss*))

;; inverse of pairlis exists??
)

;;; property list
(ito-set "property list"
  (defvar *plist* ())
  (setf (getf *plist* :a) 123)
  (intend-equal "get on a property list" 123 (getf *plist* :a))
  (setf (getf *plist* :b) '(f x))
  (intend-equal "set on a property list" '(f x) (getf *plist* :b))
)

;;
(ito-set "substitute"
  (defvar *lll* '(a b c))
  (intend-equal "atom to atom" '(a 2 c) (substitute 2 'b *lll*))
  (intend-equal "atom to term" '(a (f x) c) (substitute '(f x) 'b *lll*))

)
;;
(ito-set "subst"
  (defvar *eee* '(x y))
  (intend-equal "atom to atom" '(y y) (subst 'y 'x *eee*))
  (intend-equal "atom to term" '(x (f x)) (subst '(f x) 'y *eee*))

  (intend-equal "try to make par subst" '((f y) a) (subst '(f y) 'x (subst 'a 'y *eee*)))
  (intend-equal "i want to this" '((f a) a) (subst 'a 'y (subst '(f y) 'x *eee*)))

  (defvar *fff* '((f x)(g y)))
  (intend-equal "into subexp by subst" '((f (g z)) (g a)) (subst '(g z) 'x (subst 'a 'y *fff*)))
)

;; continuation
;; first just loop on expr
; (loop for x in x1 collect x)
; (loop for a in x1 for b in x2 do (format t "~a:~a~%" a b))
; (loop for a in x1 for b in x2 collect (cons a b))
; (loop for s1 in '((a)(b)(c)) append s1 )

(ito-set "double loop"
  (defvar x1 '(1 2 3))
  (defvar x2 '(a b c))
  (intend-equal "double loop" '((1 . a)(2 . b)(3 . c)) 
    (loop for a in x1 for b in x2 collect (cons a b)))
)

(defun traverse2 (e1 e2)
  (cond 
    ((or (atom e1)(atom e2))(cons e1 e2))
    (t (loop for se1 in e1 for se2 in e2 collect (traverse2 se1 se2)))
  )
)

(defun traversediff (e1 e2)
  (cond 
;    ((equal e1 e2) ())
    ((or (atom e1)(atom e2))(list (cons e1 e2)))
    (t (loop for se1 in e1 for se2 in e2 unless (equal se1 se2) append (traversediff se1 se2)))
  )
)

(ito-set "traverse2"
  (intend-equal "traverse2 lists" '((x . a)(y . z)) (traverse2 '(x y) '(a z)))
  (intend-equal "traverse2 lists have same" '((x . a)(b . b)(y . z)) (traverse2 '(x b y) '(a b z)))
)

(ito-set "traversediff"
  (intend-equal "traversediff same" '() (traversediff '(x y) '(x y)))
  (intend-equal "traversediff same depth" '() (traversediff '((f x) y) '((f x) y)))
  (intend-equal "traversediff lists" '((x . a)(y . z)) (traversediff '(x y) '(a z)))
  (intend-equal "traversediff lists have same" '((x . a)(y . z)) (traversediff '(x b y) '(a b z)))
  (intend-equal "traversediff depth" '((x . a)(y . z)) (traversediff '(x (b y)) '(a (b z))))
)

;; I/O
;; 標準出力を捨てる方法
(with-open-file (*standard-output* "/dev/null" :if-exists :supersede :direction :output)
 (format t "You cant see me~%")
 )

;;; documentation
(defun namida (tear)
 (:documentation "your tear is a namida")
 (format t "~%tear is namida~%")
)
(describe 'namida)

#| 
 this is a comment
 or not.
|#


;;;;; learn generic function
;; defclass

;;;* (defclass be () 
;;; (myname myvalue))
;;;#<STANDARD-CLASS COMMON-LISP-USER::BE>
;;;* (defparameter *name1* (make-instance 'be))
;;;*NAME1*
;;;* (setf (slot-value *name1* 'myname) 'Jiro)
;;;JIRO
;;;* (setf (slot-value *name1* 'myvalue) 123)
;;;123
;;;* *name1*
;;;#<BE {1002CD9A73}>
;;;* (slot-value *name1* 'myname)
;;;JIRO

;(defclass symbolic ()
; ((name :accessor name)
;  (value :accessor value)
; )
;)
;(defclass symbol (symbolic)
;)
;
;(defclass number (symbolic)
;)
;
;(defclass expr ()
; ((fsym :accessor fsym)
;  (args :accessro args)
; )
;)
;(defclass explist ()
; ((first :accessor first)
;  (after :accessor after)
; )
;)
;
;
;;defgeneric and defmethod
;
;(defgeneric whatis (name)
; (:documentation "I say what it is")
;)
;
;(defmethod whatis ((name symbol))
;)
;(defmethod whatis ((name expr))
;)
;(defmethod whatis ((name elist))
;)
;

;;; loop!
(defparameter *XX* (loop for i from 1 to 50 collect i))
(loop for c across "abcdefg" collect c)
(loop for c across "ababacd" counting (find c "ac")) ; PCL P88

;;;; fileの読み込み
;(with-open-file (stream "/some/file/name.txt") (format t "~a~%" (read-line stream)))
;To create a new file, you can write something like this:
;(with-open-file (stream "/some/file/name.txt" :direction :output) (format stream "Some text."))

(with-open-file (in "data/chose001.kqc")
  (read in)
)

;  (let ((s (read in))) s))


;NG
;(with-open-file (in "data/chose001.kqc")
;  (loop while (setf s (read-line in)) do (format t "~a~%" s))
;)


;; NG
;(defparameter ii (open "data/chose001.kqc"))
;(read-line ii)
;(read-sequence ii)
;(end-of-file ii)
;(close ii)


;; for Lid connection, to use setf connection. ?
;; atom to atom
;; C10 => C 10
;; C 11 => C11

;; gensym
;;;1. howlong

;* (gensym "abcdef")
;#:|abcdef371|
;* (gensym "abcdefghi")
;#:|abcdefghi372|
;* 

;;;2. connection of symbols
;* x1
;#:R417
;* (set x1 (gensym "R"))
;#:R418
;* x1
;#:R417
;* (eval x1)
;#:R418
;
;* (set (eval x1)(gensym "R1"))
;#:R1421
;* (eval x1)
;#:R418
;* (eval (eval x1))
;#:R1421
;

;; for rename in rubbish
;(setf v1 (gensym "V1"))
;(setf vv1 (gensym (symbol-name v1)))
;(set vv1 v1)
;(eval vv1) -> v1
;
;* (symbol-name vv1)
;"v1373374"
;

;;;symbol-nameがどんどん長くなる
;一つ前の変数名とか、最初の変数名とか
;* (symbol-name vv1)
;"v1373374"
;* (setf vvv1 (gensym (symbol-name vv1)))
;; in: SETF VVV1
;;     (SYMBOL-NAME VV1)
;; 
;; caught WARNING:
;;   undefined variable: COMMON-LISP-USER::VV1
;
;;     (SETF VVV1 (GENSYM (SYMBOL-NAME VV1)))
;; ==>
;;   (SETQ VVV1 (GENSYM (SYMBOL-NAME VV1)))
;; 
;; caught WARNING:
;;   undefined variable: COMMON-LISP-USER::VVV1
;; 
;; compilation unit finished
;;   Undefined variables:
;;     VV1 VVV1
;;   caught 2 WARNING conditions
;#:|v1373374375|

; こういう分け方もありそう
;V1が最初の変数名とする
;* (setf a1 (gensym "V1."))
;#:V1.377
;
;* (setf aa1 (gensym  (format nil "~a." (symbol-name a1))))
;#:V1.377.379
;分けたかったらこうなる。


;;最初の名前を知りたいならば
;;* (subseq (symbol-name aa1) 0 (position #\. (symbol-name aa1)))
;;"V1"
;;
;;ただし、変数名に.を使ってはいけない・・・
;;使いたかったら、区切り記号を変える


;関数が定義されているかどうか
;* (fboundp 'a1)
;NIL
;* (fboundp 'evenp)
;T
;* 

;atomが定義/bindされているかどうか
;* (boundp 'a1)
;T
;* (boundp 'b1)
;NIL



;;;
(multiple-value-bind (x y z)
  1 2 3)

(values 11 12 13)

(setf x 'a y 'b z 'c)

(multiple-value-bind (x y z) (values 11 12 13) (+ x y z))

;;; duplicate
(delete-duplicates '(a b c b d))
; (a b c d)
;


; (make-symbol "abc") == #:|abc|
; (symbol-name :abc) == "ABC"
"ABC"か#:|abc|からアトムabcを作りたい
;atomはpackageに属するのか


; (intern "abc") == |abc|
; (intern :abc) : エラー



;;; incf
(defparameter cct 0)
(incf cct)
(incf cct)
(incf cct)
(incf cct)


;;;; prompt
; Practical Common Lisp P49

(defun prompt-read (prompt)
 (format *query-io* "~a: " prompt)
 (force-output *query-io*)
 (read-line *query-io*))

(prompt-read "hi all")


;;; string reading
 (with-open-stream (s (make-string-input-stream "1 2 3 4"))
    (+ (read s) (read s) (read s)))


;;; for atom (symbol-plist) works
(setf (get 'aaa :name) 123)
(setf (get 'aaa :value) "abc")
(symbol-plist 'aaa)



