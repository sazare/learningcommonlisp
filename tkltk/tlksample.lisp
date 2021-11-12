;;;; 新しいウィンドウを作成する
;; from https://kamuycikap.hatenablog.com/entry/2020/12/16/215030

(ql:quickload :ltk)

(in-package :ltk)

(with-ltk ()
  (wm-title *tk* "GUIでハローワールド")
  (minsize *tk* 300 300)                ; 300px X 300px

  (let* ((b (make-instance 'button 
                          :master nil
                          :text "Press Me"
                          :command (lambda () (format t "Hello World!~%")))))
    (pack b))
)


