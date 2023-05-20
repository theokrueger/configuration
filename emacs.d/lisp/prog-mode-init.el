;; prog-mode-init.el
;; settings for all programming modes

;; indentation
(setq-default indent-tabs-mode nil) ; use spaces instead of tabs
(setq-default tab-width 8) ; set the tab width to 8 spaces


;; rainbow delimiters
(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; dont touch this
(provide 'prog-mode-init)
