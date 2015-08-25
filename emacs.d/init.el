;; Vars
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(custom-set-faces)

;; Python
(setq python-shell-interpreter "ipython3")
(setq python-indent 4)
(electric-pair-mode t)

;; C
(setq-default c-basic-offset 4)

;; Whitespace
(require 'whitespace)
(setq-default whitespace-style '(face trailing lines-tail))
(global-whitespace-mode 1)


;; Hook
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Keys bindings
(global-set-key (kbd "C-w") 'kill-whole-line)

;; Package install
(require 'package)
(add-to-list 'package-archives
			 '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)


;; Packages

;; auto-complete
(ac-config-default)

;; Elpy
(elpy-enable)
