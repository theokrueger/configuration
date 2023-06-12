;; prog-mode-init.el
;; settings for all programming modes

;; indentation
(setq-default
  indent-tabs-mode nil ;; spaces over tabs
  default-tab-width 8 ;; 8space tabs
  tab-width 8)


;; rainbow delimiters
(require-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; dont touch this
(provide 'prog-mode-init)
