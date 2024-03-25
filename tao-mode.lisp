(in-package "EDITOR")


;;; The command to invoke TAO Mode.

(defcommand "Tao Mode" (p)
  "Put current buffer in TAO Mode." 
  "Put current buffer in TAO Mode."  
  (declare (ignore p))
  (setf (buffer-major-mode (current-buffer)) "Tao"))


(defparameter *tao-syntax-table*
  (create-syntax-table  :string-escape #\\
                        :d-escape #\#
                        :double-comment #\#
                        :escape #\\
                        :comment #\;
                        :nested t
                        :end-comment #\Newline
                        :second-comment #\|
                        :first-close-comment #\|
                        :second-close-comment #\#
                        :string #\" 
                        :close '(#\) #\} #\])
                        :open '(#\( #\{ #\[)
                        :quote-char #\'
                        :backquote-char #\`
                        :comma-char #\,
                        :string-within-symbol #\|
                        :whitespace '(#\Tab 
                                      #\Space
                                      #\Formfeed
                                      #\Newline
                                      #\Return)))


(defmode "Tao"
  :major-p t
  :setup-function 'setup-tao-mode
  :aliases '("Dao")
  :vars '((Paren-Pause-Period . nil)
	  (Highlight-Matching-Parens . T)
	  (Comment-Start . ";")
	  (Comment-Begin . ";")
	  (Indent-Function . indent-for-lisp)
          (Indent-Region-Function . lisp-indent-region-for-commands)
	  (Check-Mismatched-Parens . :move)
          (Fill-Paragraph-Function . lisp-fill-paragraph)
          (spelling-line-preprocessor . lisp-mode-spelling-preproecssor)
          (spelling-complex-filter . lisp-mode-spelling-complex-filter))
  :syntax-table *tao-syntax-table*)


;(bind-key "Lisp Insert )" *close-bracket-char-object* :mode "Tao")


(defun setup-tao-mode (buffer)
  (unless (variable-value-if-bound 'current-package :buffer buffer)
    (find-in-package buffer)
    ;(font-lock-fontify-buffer buffer)
    (ignore-errors (eval (read-from-string "(tao:tao)")))))


(defun tao-buffer-p (buffer)
  (string= (buffer-major-mode-name buffer) "Tao"))


(define-editor-mode-variable add-newline-at-eof-on-writing-file "tao" T)


;;; *EOF*
