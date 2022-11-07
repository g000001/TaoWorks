;;; -*- mode: Lisp; coding: utf-8  -*-

(in-package "EDITOR")


(defparameter *tao-mode-control-structures-fsa*
  (make-fsa
   (string-append
    "("
    (regexp-opt '("print-unreadable-object" "pprint-logical-block"
                  "with-standard-io-syntax" "with-compilation-unit"
                  "with-package-iterator" "with-hash-table-iterator" "with-open-stream"
                  "with-open-file" "with-output-to-string" "with-input-from-string"
                  "with-accessors" "with-slots" "inline" "progi" "prog2" "prog1" "values"
                  "multiple-value-bind" "destructuring-bind" "prog"
                  "with-simple-restart" "restart-bind" "restart-case" "handler-bind"
                  "handler-case" "return" "declare" "declaim" "proclaim"
                  "for" "forn" "image" "imagen" "select" "selectq" "ntrim" "trim"
                  "do-all-symbols" "do-external-symbols" "do-symbols" "dolist" "dotimes"
                  "do*" "do" "loop" "etypecase" "typecase" "ecase" "case"
                  "catcher" "with-readtable" "seq" "seqt" "!" "&"
                  "cond" "unless" "when" "")
                t)
    "\\>")))


(defmacro unless-defined (def name args &body body) 
  (unless (or (fboundp name) (special-operator-p name) (macro-function name))
    `(,def ,name ,args ,@body)))

(unless-defined defun lisp-font-lock-mark-block-function (point other-point)
  (get-defun-start-and-end-points point point other-point))

(setf (variable-value 'font-lock-fontify-syntactically-region-function
                      :mode "Tao")
      #'lisp-font-lock-fontify-syntactically-region)

(setf (variable-value 'font-lock-fontify-keywords-region-function
                      :mode "Tao")
      #'lisp-font-lock-fontify-keywords-region)

(setf (variable-value 'font-lock-mark-block-function
                      :mode "Tao")
      #'lisp-font-lock-mark-block-function)

(add-global-hook tao-mode-hook 'turn-on-font-lock)

