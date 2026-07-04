;; the folklore quine -- Lisp oral tradition, 1960s, author unknown
;; (which is itself the most Lisp thing about it).
;;
;; It does not print itself; it *is* itself: a fixed point of eval.
;; The serpent's tail is already in its mouth.
;;
;; sbcl --script quine.lisp

(defvar *ouroboros*
  '((lambda (x) (list x (list 'quote x)))
    '(lambda (x) (list x (list 'quote x)))))

(format t "the expression:~%~S~%~%evaluates to:~%~S~%~%eval fixed point: ~A~%"
        *ouroboros*
        (eval *ouroboros*)
        (if (equal *ouroboros* (eval *ouroboros*)) "yes. it devours itself and remains." "no"))
