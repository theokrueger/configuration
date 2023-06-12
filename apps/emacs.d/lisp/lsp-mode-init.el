;; lsp-mode.e;
;; settings related to language server protocol

(require-package 'lsp-mode)
(require-package 'lsp-ui)

;; settings
(setq-default
  lsp-log-io nil         ;; ensure logging off
  lsp-auto-configure nil ;; no auto configure lsp ui and such
  lsp-idle-delay 0.500)  ;; wait .5s for performance reasons

;;(setq )

;; lua
;; requires https://github.com/Alloyed/lua-lsp
(require-package 'luarocks)


(lsp-deferred)

;; dont touch this
(provide 'lsp-mode-init)
