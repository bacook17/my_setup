;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "~/.emacs.d/lisp/")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes (quote (misterioso)))
 '(custom-safe-themes
   (quote
    ("150e6e8c5fe6a5377ed334f1d9f4f59f8d8255d6e8ac92aa0193fe02a5c59e6d" "1eb113df6b9be2b3cb49ef315f299148910c65f0e868edf31b5a994c01953e39" "b48a53b5f958509e18d3e5213f132608aabc444cc882136b0e31aa46df043ec6" "144fb347eb78112504b3538e219b8c54070fab6dadf92679c45a78d737408cfb" "315ce87d01b9692280c08a27cf58ed3b8c843915b5f7f67e32d37b84be882bce" default)))
 '(flymake-cursor-error-display-delay 0.5)
 '(flymake-cursor-number-of-errors-to-display 3)
 '(flymake-no-changes-timeout 2.0)
 '(flymake-proc-allowed-file-name-masks
   (quote
    (("\\.py\\'" flymake-pycodecheck-init nil nil)
     ("[0-9]+\\.tex\\'" flymake-proc-master-tex-init flymake-proc-master-cleanup nil)
     ("\\.tex\\'" flymake-proc-simple-tex-init nil nil))))
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (flymake-cursor python-black melpa-upstream-visit)))
 '(python-black-extra-args (quote ("-S" "-l 79")))
 '(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "gray00" :foreground "gray80" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 1 :width normal :foundry "default" :family "default"))))
 '(flymake-error ((((class color)) (:background "color-88"))))
 '(flymake-warning ((((class color)) (:background "color-94")))))
(add-hook 'latex-mode-hook 'auto-fill-mode)
(add-hook 'latex-mode-hook 'flyspell-mode)
;; Set the number to the number of columns to use.
(setq-default fill-column 79)

;; Add Autofill mode to mode hooks.
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Show line number in the mode line.
(line-number-mode 1)

;; Show column number in the mode line.
(column-number-mode 1)

(global-font-lock-mode 1)
(load-library "python")

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(setq interpreter-mode-alist
      (cons '("python" . python-mode)
	    interpreter-mode-alist)
      python-mode-hook
      '(lambda () (progn
		    (set-variable 'py-indent-offset 4)
		    (set-variable 'indent-tabs-mode nil))))
(require 'column-marker)
(set-face-background 'column-marker-1 "red")
(add-hook 'python-mode-hook
	  (lambda () (interactive)
	    (column-marker-1 fill-column)))
;; Setup for Flymake code checking.
(require 'flymake)
;; (require 'flymake-cursor)
(load-library "flymake-cursor")

;; Script that flymake uses to check code. This script must be
;; present in the system path.
(setq pycodechecker "pychecker")

(global-set-key "\C-k" nil)
(global-set-key "\C-k\C-m" `python-black-region)

(when (load "flymake" t)
  (defun flymake-pycodecheck-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
      		       'flymake-create-temp-inplace)))
      (list pycodechecker (list temp-file))))
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pycodecheck-init)))

(add-hook 'python-mode-hook 'flymake-mode)

;;allow installing packages
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
