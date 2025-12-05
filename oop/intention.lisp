
(defclass intention () )

(defclass testcase ())

(defclass testsuite ())

(defclass testsuite ())

サンプル
;; vanilla

クラスとして意図/itoを定義する。

(defclass 意図 () (name))
(defparameter ito1 (make-instance '意図))
(setf (slot-value 'ito1 :name) "テスト1")
(defmethod check (x '意図)

意図チェックの書き方

メソッドにするとしたら、全部同じmethod名になるのは、どう区別をするか。
みたいな?
(defgeneric check (ito :意図 :what :how)

;; class var
(defclass 意図 () ((results :initform () :allocation  :class ) ))


;;;使い方を考える
ito-caseとito-checker

実行はどういう形

結果はどういう形

testcase/testsuiteに対してcheckを実行する
結果は valid/fail

checkの定義はどこ

ito-caseとは何か?


複数のcheckerをまとめるのはgenericか??
そのときは、genericのなんとかいう名前のgeneric関数を全部呼ぶのか??




