;; essential functions of common lisp

(in-package :mybase)

;; refer: https://lisphub.jp/common-lisp/cookbook/index.cgi?Universal%20Timeを文字列に変換する
;;        and reference manual

(defun time-current-secs ()
  (let (sec min hr day mon year dow daylight-p zone)
    (multiple-value-setq (sec min hr day mon year dow daylight-p zone)
      (decode-universal-time (get-universal-time)))
    (+ sec (* min 60) (* hr 3600)(* day 86400))
  )
)

;; today as string
(defun today ()
  (multiple-value-bind (second
                      minute
                      hour
                      date
                      month
                      year
                      day-of-weak
                      daylight-p
                      time-zone)
    (get-decoded-time)
  (format nil "~d-~d-~d" year month date))
)

(defun test-now ()
  (time-now)
)

