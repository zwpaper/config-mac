;; Vars
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(add-to-list 'exec-path "/usr/local/bin/")


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
(global-set-key (kbd "C->") 'other-window)


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


;; Theme
(add-to-list 'custom-theme-load-path
             "~/.emacs.d/themes/emacs-color-theme-solarized/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/tomorrow/")
(add-to-list 'load-path "~/.emacs.d/themes/tomorrow/")
(set-frame-parameter nil 'background-mode 'dark)
(set-terminal-parameter nil 'background-mode 'dark)
; (if (display-graphic-p)
; (load-theme 'solarized t)
;; Theme Changer base on sun rise/set
(setq calendar-location-name "ChangChun, China")
(setq calendar-latitude 43.8)
(setq calendar-longitude 125.28)
(require 'theme-changer)
(change-theme 'tomorrow-night 'solarized)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1"
     "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd"
     "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(menu-bar-mode nil)
 '(tool-bar-mode nil)
 '(scroll-bar-mode nil))
