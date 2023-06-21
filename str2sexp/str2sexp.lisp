(read (make-string-input-stream "(abc)"))
=>
(abc)


(let ((s (make-string-input-stream "(abc)(bb)"))) (list (read s) (read s)))
=>
((abc)(bb))

