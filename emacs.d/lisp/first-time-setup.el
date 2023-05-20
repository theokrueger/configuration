;; first-time-setup.el
;; settings and configurations that only need to be run during first time setup
;; please run this file once by doing M-: (require 'first-time-setup)

;; compile all files in config dir
(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)

;; dont touch this
(provide 'first-time-setup)
