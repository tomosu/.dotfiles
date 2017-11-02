
;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;;;;;;;;;;;;;;;

(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'yatex-mode)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)          ;; 曖昧マッチ


;; auto-complete c-headers
(add-hook 'c-mode-hook
	  (lambda ()
	    (add-to-list 'ac-sources 'ac-source-c-headers)
	    (add-to-list 'ac-sources 'ac-source-c-header-symbols t)))

;; ac-etage
(custom-set-variables
 '(ac-etags-requires 1))

(eval-after-load "etags"
  '(progn
     (ac-etags-setup)))

(add-hook 'c-mode-common-hook 'ac-etags-ac-setup)
(add-hook 'ruby-mode-common-hook 'ac-etags-ac-setup)


;;-----------------
;; Python
;;-----------------

;; jedi
(require 'epc)
(require 'auto-complete-config)
(require 'python)
;;;;; PYTHONPATH上のソースコードがauto-completeの補完対象になる ;;;;;
(setenv "PYTHONPATH" "~/virtual_envs/tf_env/lib/python3.6/site-packages")
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; pyflakes
;(add-hook 'find-file-hook 'flymake-find-file-hook)
(add-hook 'python-mode-hook
	  '(lambda ()
	     (flymake-mode t)))
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "~/virtual_envs/tf_env/bin/pyflakes"  (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))

; show message on mini-buffer
(defun flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))
(add-hook 'post-command-hook 'flymake-show-help)


;--------------------------------------------------------------------------------
; basic configurations
(column-number-mode t)
(line-number-mode t)
; (tool-bar-mode nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
; backups, those damned ~ files
(setq make-backup-files nil)                 ; prevent backups
(setq version-control 'never)                ; never make numbered backups

;; ; auto save
;; (auto-save-mode t)                           ; enable auto-save mode
;; (setq auto-save-default t)                   ; autosave all visited files
;; (setq delete-auto-save-files t)		     ; delete autosaved file on proper save
;; (setq auto-save-interval 500)		     ; the number of keystrokes before autosaving
;(setq auto-save-visited-file-name t)	     ; autosaves to actual file

;; ; Save places in files for when reloading them
;; (require 'saveplace)
;; (setq-default save-place t)
;; (setq save-place-version-control 'never)

;; ; disable indenting using tabs
;; (setq indent-tabs-mode nil)

; enable buffer list
(define-key global-map "\C-x\C-b"  'electric-buffer-list)

;--------------------------------------------------------------------------------
; faces
;(defvar my-font  "-*-fixed-medium-*-*-*-16-*-*-*-*-*-*-*"  "Default Normal Font")
;(defvar my-bold-font  "-*-fixed-bold-*-*-*-16-*-*-*-*-*-*-*"  "Default Bold Font")

;; ;; appropriate fonts
;(set-face-font 'default                my-font)
;; (set-face-font 'italic                 my-font)
;; (set-face-font 'modeline               my-font)
;(set-face-font 'bold                   my-bold-font)
;; (set-face-font 'bold-italic            my-bold-font)

;; (set-face-font 'font-lock-keyword-face my-bold-font)
;; (set-face-font 'font-lock-type-face    my-bold-font)

;--------------------------------------------------------------------------------
; basic colours
(set-face-foreground 'default           "white")
(set-face-background 'default           "black")

; Searching
(set-face-foreground 'isearch           "white")
(set-face-background 'isearch           "red")

; e.g. selecting buffers
(set-face-foreground 'highlight         "#440000")
(set-face-background 'highlight         "#ffeedd")

; Bottom of buffer line
;(set-face-foreground 'modeline          "#800000")
;(set-face-background 'modeline          "#e0e0e0")

; Pointer
(setq x-pointer-foreground-color        "black")
(setq x-pointer-background-color        "white")

(setq minibuffer-max-depth nil)

;; font-lock
(global-font-lock-mode t)

;; 文字コード
(set-language-environment 'Japanese)
;(set-default-coding-systems 'euc-jp)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
;(set-keyboard-coding-system 'sjis-mac)
(set-keyboard-coding-system 'utf-8)
;(set-terminal-coding-system 'euc-jp)
(set-terminal-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
;(set-buffer-process-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq network-coding-system-alist
      '(("nntp" . (junet-unix . junet-unix))
       (110 . (no-conversion . no-conversion))
       (25 . (no-conversion . no-conversion))
       ))

;--------------------------------------------------------------------------------
;; add local lisp directory to path
(setq load-path (cons "~/local/lisp/" load-path))

;; Setup for verilog-mode
;; Load verilog mode only when needed
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
;; Any files that end in .v should be in verilog mode
;; (setq auto-mode-alist (cons  '("\\.v\\'" . verilog-mode) auto-mode-alist))
(setq auto-mode-alist
      (append '(("\\.v$" . verilog-mode)
		("\\.sv$" . verilog-mode)
		("\\.svh$" . verilog-mode)
		("\\.vnet$" . verilog-mode)
		) auto-mode-alist))


;; Any files in verilog mode should have their keywords colorized
(add-hook 'verilog-mode-hook
	  '(lambda ()
	     (font-lock-mode 1)
	     (setq verilog-indent-level             2
		   verilog-indent-level-module      2
		   verilog-indent-level-declaration 2
		   verilog-indent-level-behavioral  2
		   verilog-indent-level-directive   2
		   verilog-case-indent              4
		   verilog-auto-newline             nil
		   verilog-auto-indent-on-newline   t
		   verilog-tab-always-indent        t
		   verilog-auto-endcomments         nil
		   verilog-minimum-comment-distance 40
		   verilog-indent-begin-after-if    nil
		   verilog-auto-lineup              'declarations
		   verilog-highlight-p1800-keywords nil
		   verilog-linter			 "my_lint_shell_command"
		   )
	     ))

;; C++ mode
(setq auto-mode-alist
      (append '(("\\.c$" . c++-mode)
		("\\.cpp$" . c++-mode)
		("\\.pzc$" . c++-mode)
		("\\.h$" . c++-mode)
		("\\.f$" . c++-mode)
		) auto-mode-alist))

;; Ruby mode
(autoload 'ruby-mode "ruby-mode" "Ruby mode" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))

;; Makefile mode
(setq auto-mode-alist
      (append '(("Makefile" . makefile-mode)
		("makefile" . makefile-mode)
		("\\.mk$" . makefile-mode)
		) auto-mode-alist))

;; Haskell mode
(add-to-list 'load-path "~/local/lisp/haskell-mode-2_9_1")
(require 'haskell-mode)
(require 'haskell-cabal)
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . haskell-mode))
(custom-set-variables
     '(haskell-mode-hook '(turn-on-haskell-indentation)))

;; LLVM
(setq load-path
      (cons (expand-file-name "~/local/lisp/llvm") load-path))
(require 'llvm-mode)

;--------------------------------------------------------------------------------

;; Paren matching
(if (featurep 'XEmacs)
    ((require 'paren)
     (paren-set-mode 'blink-paren))
  (show-paren-mode t))

;; toolbar
(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(current-language-environment "Japanese")
 '(default-input-method "japanese")
 '(global-font-lock-mode t nil (font-lock))
 '(show-paren-mode t nil (paren))
 '(toolbar-visible-p nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )

;; for ChangeLog memo
(setq user-full-name "hoge")
(setq user-mail-address "hoge@hoge.co.jp")

(put 'downcase-region 'disabled nil)

;; comment-reagion
(global-set-key "\C-cc" 'comment-region)
(global-set-key "\C-cu" 'uncomment-region)

;; goto-line
(global-set-key "\C-cg" 'goto-line)


(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; ;; Set coding system at last
;; (set-default-coding-systems 'utf-8)
