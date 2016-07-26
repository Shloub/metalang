; Pour utiliser ce mode, il faut ajouter ceci dans son .emacs :
;(setq auto-mode-alist (cons '("\\.metalang$" . metalang-mode) auto-mode-alist))
;(autoload 'metalang-mode "/home/max/metalang/calc/tools/metalang-mode.el" "Mode majeur pour éditer du code Metalang" t)


; mode inspire de : http://www.emacswiki.org/cgi-bin/wiki/ModeTutorial
(defvar metalang-mode-hook nil)

(defconst metalang-font-lock-keywords-li
  '("def" "inline" "enum" "record" "def" "while" "with" "for" "to" "if" "then" "else" "elsif" "do" "end" "return" "main" "print" "read" "skip")
  "metalang keywords list")

(defconst metalang-font-lock-keywords-0
  (list
   (cons (concat "\\<\\(" (regexp-opt metalang-font-lock-keywords-li t) "\\)\\>") '( 0 font-lock-keyword-face))
   )
  "metalang keywords"
  )

(defconst metalang-font-lock-constants-0
  (list
   (cons (concat  "\\<\\(" (regexp-opt '("true" "false") t)  "\\)\\>") '( 0 font-lock-constant-face))
   '("\\s-\\([0-9]+\\)\\s-" . font-lock-constant-face)
   '("\\('[^']+'\\)" . font-lock-constant-face)
   )
  "metalang constants"
  )

(defconst metalang-font-lock-types-0
  (list
   '("\\(array<[-a-zA-Z0-9_.<>]+>\\)" . font-lock-type-face)
   (cons (concat  "\\<\\(" (regexp-opt '("int" "string" "bool" "void") t) "\\)\\>") '( 0 font-lock-type-face))
   '("\\(@[-a-zA-Z0-9_.]+\\)" . font-lock-type-face)
   )
  "metalang constants"
  )

(defconst metalang-font-lock-syntax-0
   '(
     ("\\(\\#.*\\)" . font-lock-comment-face)
     ("\\([-a-zA-Z0-9_]+\\)\\s-*(" ( 0 font-lock-function-name-face))
     ("\\(\\.[-a-zA-Z0-9_.]+\\)" . font-lock-reference-face)
     ("\\([-a-zA-Z0-9_.]+\\)\\s-:" . font-lock-reference-face)
     )
   "variable syntax")

(defvar metalang-font-lock-keywords
  (append 
   metalang-font-lock-constants-0
   metalang-font-lock-types-0
   metalang-font-lock-keywords-0
   metalang-font-lock-syntax-0
   )
  "Keyword highlighting specification for metalang.")

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
	 (looking-at "^[ \t]*end$")
	 (looking-at "^[ \t]*end\\s-")
	 )
	)

(defun metalang-isbegin ()
	""
	(or
	 (looking-at "[^\n]*\\(main\\|\\do\\|then\\|else\\|record\\|enum\\)")
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


(defvar metalang-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?/ ". 14" st)
    (modify-syntax-entry ?* ". 23" st)
    (modify-syntax-entry ?_ "w" st)
    st )
  "syntax table" )

(defun metalang-mode ()
  "Metalang major mode"
  (interactive)
;  (pop-to-buffer "*Metalang*" nil)
  (kill-all-local-variables)
  (set (make-local-variable 'font-lock-defaults)
       '(metalang-font-lock-keywords))
  (setq default-tab-width 2)
  (setq major-mode 'metalang-mode)
  (setq mode-name "Metalang")
  (set (make-local-variable 'indent-line-function) 'metalang-indent-line)
  (set-syntax-table metalang-mode-syntax-table)
  (use-local-map metalang-mode-map)
 ; (run-hooks 'metalang-mode-hook)
)
(provide 'metalang-mode)
