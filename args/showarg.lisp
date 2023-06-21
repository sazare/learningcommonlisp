

(format t "~a~%" SB-EXT:*POSIX-ARGV*)

(loop for x in SB-EXT:*POSIX-ARGV* do
  (format t " ~a~%" x)
)
 


