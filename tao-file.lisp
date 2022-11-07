;;; -*- mode: Lisp; coding: utf-8  -*-

(cl:in-package "EDITOR")

(define-file-type-hook ("tao") (buffer type)
  (declare (ignore type))
  (setf (buffer-major-mode buffer) "Tao")
  (when (find-package "https://github.com/g000001/lw-paredit")
    (setf (buffer-minor-mode buffer "Paredit") T)
    (turn-on-font-lock buffer T))
  (let ((pathname (buffer-pathname buffer)))
    (unless (and pathname (probe-file pathname))
      (insert-string
       (buffer-point buffer)
       (format nil
               ";;; -*- mode: Tao; coding: utf-8  -*-~2%~A~2%"
               (if (find-package 'btao)
                   "(tao:tao)
\(cl:in-package \"BTAO\")"
                   ""))))))