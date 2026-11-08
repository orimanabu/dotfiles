;; -*- lexical-binding: nil; -*-

(require 'ucs-normalize)
(add-to-list 'load-path (expand-file-name "~/.local/share/emacs/site-lisp/lookup"))

(load "lookup-autoloads")

;; (autoload 'lookup "lookup" nil t)
;; (autoload 'lookup-region "lookup" nil t)
;; (autoload 'lookup-word "lookup" nil t)
;; (autoload 'lookup-select-dictionaries "lookup" nil t)

;;(setq lookup-search-agents '((ndeb "~/Documents/dic/Readers")))
(setq lookup-search-agents '((ndeb "~/Data/dicts/KENKYUSHA_READERS_PLUS_V2")))
