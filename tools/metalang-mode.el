; Pour utiliser ce mode, il faut ajouter ceci dans son .emacs :
;(setq auto-mode-alist (cons '("\\.metalang$" . metalang-mode) auto-mode-alist))
;(autoload 'metalang-mode "/home/max/metalang/calc/tools/metalang-mode.el" "Mode majeur pour éditer du code Metalang" t)


; mode inspire de : http://www.emacswiki.org/cgi-bin/wiki/ModeTutorial
(defvar metalang-mode-hook nil)
(defvar metalang-font-lock-keywords
   '(

      ("[-a-zA-Z0-9_.]+\\s-:\\s-\\([-a-zA-Z0-9_.<>]+\\)" (1 font-lock-type-face))

     ("\\('[^']+'\\)" (1 font-lock-constant-face)) ; char regexp
     ("\\([-a-zA-Z0-9_]+\\)\\s-*(" (1 font-lock-function-name-face)) ; function regexp
     ("\\s-\\(record\\|def\\|while\\|with\\|for\\|to\\|if\\|then\\|else\\|elsif\\|do\\|end\\|return\\|main\\|print\\|read\\|skip\\)\\s-"
      (1 font-lock-keyword-face))
     ("^\\(record\\|def\\|while\\|with\\|for\\|to\\|if\\|then\\|else\\|elsif\\|do\\|end\\|return\\|main\\|print\\|read\\|skip\\)\\s-"
      (1 font-lock-keyword-face))

      ("record\\s-\\([-a-zA-Z0-9_.<>]+\\)" (1 font-lock-type-face))
      ("def\\s-\\([-a-zA-Z0-9_.<>]+\\)\\s-[-a-zA-Z0-9_.]+"
       (1 font-lock-type-face))
      ("read\\s-\\([-a-zA-Z0-9_.<>]+\\)\\s-[-a-zA-Z0-9_.]+"
       (1 font-lock-type-face))
      ("print\\s-\\([-a-zA-Z0-9_.<>]+\\)\\s-[-a-zA-Z0-9_.]+"
       (1 font-lock-type-face))
      ("([ \t]*\\([-a-zA-Z0-9_.<>]+\\)\\s-[-a-zA-Z0-9_.]+"
       (1 font-lock-type-face))
      (",[ \t]*\\([-a-zA-Z0-9_.<>]+\\)\\s-[-a-zA-Z0-9_.]+"
       (1 font-lock-type-face))
      ("\\(true\\|false\\)" (1 font-lock-constant-face t t))
     )
   "Keyword highlighting specification for `metalang-mode'.")
(defvar metalang-mode-map
  (let ((map (make-keymap)))
    (define-key map "\C-j" 'newline-and-indent)
    map)
  "Keymap for Metalang major mode")

(defun metalang-isend ()
	""
	(or
	 (looking-at "^[ \t]*else")
	 (looking-at "^[ \t]*elsif")
	 (looking-at "^[ \t]*end")
	 )
	)

(defun metalang-isbegin ()
	""
	(or
	 (looking-at "[^\n]*\\(main\\|\\do\\|then\\|else\\|record\\)")
	 (looking-at "[^\n]*\\(def\\s-[^ ]+\\s-[-a-zA-Z0-9_.]+(\\)[^\n]*")
	 )
	)

(defun metalang-indent-line ()
  "Indent current line as METALANG code"
  (interactive)
  (beginning-of-line)
  (if (bobp)
      (indent-line-to 0)
    (let ((not-indented t) cur-indent)
      (if (metalang-isend)
					(progn
						(save-excursion
							(forward-line -1)
							(setq cur-indent (- (current-indentation) default-tab-width)))
						(if (< cur-indent 0)
								(setq cur-indent 0)))
        (save-excursion
          (while not-indented
            (forward-line -1)
						(if
								(metalang-isbegin)
								(progn
									(setq cur-indent (+ (current-indentation) default-tab-width))
									(setq not-indented nil))
							(if (metalang-isend)
									(progn
										(setq cur-indent (current-indentation))
										(setq not-indented nil))
                (if (bobp) (setq not-indented nil))
								)
							)
						)))
      (if cur-indent
          (indent-line-to cur-indent)
        (indent-line-to 0) ; If we didn't see an indentation hint, then allow no indentation
				)
			)))

(defun metalang-mode ()
  "Metalang major mode"
  (interactive)
;  (pop-to-buffer "*Metalang*" nil)
;  (kill-all-local-variables)
  (set (make-local-variable 'font-lock-defaults)
       '(metalang-font-lock-keywords))
  (setq default-tab-width 2)
  (setq major-mode 'metalang-mode)
  (setq mode-name "Metalang")
  (set (make-local-variable 'indent-line-function) 'metalang-indent-line)
 ; (set-syntax-table metalang-mode-syntax-table)
  (use-local-map metalang-mode-map)
 ; (run-hooks 'metalang-mode-hook)
)
(provide 'metalang-mode)
