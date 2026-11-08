;;; init.el --- My init.el  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Naoya Yamashita

;; Author: Naoya Yamashita <conao3@gmail.com>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; My init.el.

;; alias Emacs='/opt/homebrew/Cellar/emacs-plus@30/30.1/Emacs.app/Contents/MacOS/Emacs'
;; alias Emacs.app='open /opt/homebrew/Cellar/emacs-plus@30/30.1/Emacs.app'
;; Emacs --batch -f batch-byte-compile init.el

;;; Code:

;; this enables this running method
;;   emacs -q -l ~/.debug.emacs.d/init.el
(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

;; ここにいっぱい設定を書く

;; for native compile
(setenv "LIBRARY_PATH"
        (string-join
         '("/opt/homebrew/opt/gcc/lib/gcc/current"
           "/opt/homebrew/opt/libgccjit/lib/gcc/current"
           "/opt/homebrew/opt/gcc/lib/gcc/current/gcc/aarch64-apple-darwin24/14")
         ":"))

;; "Warning (files): Missing ‘lexical-binding’ cookie" のポップアップを非表示にする
(with-eval-after-load 'warnings
  (add-to-list 'warning-suppress-types '(files missing-lexbind-cookie)))

(add-to-list 'load-path (expand-file-name "~/.local/share/emacs/local"))


(setq default-frame-alist
      (append '((width                . 140)  ; フレーム幅
                (height               . 60 ) ; フレーム高
                (left                 . 170 ) ; 配置左位置
                (top                  . 30 ) ; 配置上位置
                (line-spacing         . 0  ) ; 文字間隔
                (left-fringe          . 12 ) ; 左フリンジ幅
                (right-fringe         . 12 ) ; 右フリンジ幅
                (menu-bar-lines       . 1  ) ; メニューバー
                (cursor-type          . box) ; カーソル種別
                (alpha                . 100) ; 透明度
                )
              default-frame-alist))
(setq initial-frame-alist default-frame-alist)

(blink-cursor-mode 0)

(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)
;; ヘルプの表示を M-? 変更
(define-key global-map "\M-?" 'help-for-help)

(setq mac-option-modifier 'super)

;; ファイル名検索
(define-key global-map [(super i)] 'find-name-dired)
;; ファイル内検索
(define-key global-map [(super f)] 'rgrep)


;; cmd as meta for emacs-plus
(when (and (eq window-system 'ns)
	   (eq system-type 'darwin)
	   (display-graphic-p))
  (setq mac-option-modifier nil
        mac-command-modifier 'meta))

(load "lookup")

(progn
  (define-key global-map "\C-x\C-b" 'electric-buffer-list)
  ;;(load-file "~/bs-h.el")
  (load "bs-h")
  (require 'bs)
  (setq bs--show-all t)
  (setq bs-default-configuration "all")
  (define-key global-map "\C-x\C-b" 'bs-show))

;; (leaf paren
;;   :doc "highlight matching paren"
;;   :tag "builtin"
;;   :custom ((show-paren-delay . 0.1))
;;   :global-minor-mode show-paren-mode)

(provide 'init)

;; Local Variables:
;; indent-tabs-mode: nil
;; End:

(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

(leaf autorevert
  :doc "revert buffers when files on disk change"
  :tag "builtin"
  :custom ((auto-revert-interval . 1))
  :global-minor-mode global-auto-revert-mode)

(leaf cc-mode
  :doc "major mode for editing C and similar languages"
  :tag "builtin"
  :defvar (c-basic-offset)
  :bind (c-mode-base-map
         ("C-c c" . compile))
  :mode-hook
  (c-mode-hook . ((c-set-style "bsd")
                  (setq c-basic-offset 4)))
  (c++-mode-hook . ((c-set-style "bsd")
                    (setq c-basic-offset 4))))

(leaf paren
  :doc "highlight matching paren"
  :tag "builtin"
  :custom ((show-paren-delay . 0.1))
  :global-minor-mode show-paren-mode)

(leaf beacon
  :ensure t
  :global-minor-mode t)

(leaf volatile-highlights
  :ensure t
  :global-minor-mode t)

(leaf anzu
  :ensure t
  :global-minor-mode global-anzu-mode
  :bind
  (("M-%" . anzu-query-replace))
  )

(leaf markdown-mode
  :ensure t
  :mode
  (("\\.md\\'" . gfm-mode))
  )

(leaf go-mode)
(leaf solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark-high-contrast t))

;; (leaf ivy
;;   :doc "Incremental Vertical completYon"
;;   :req "emacs-24.5"
;;   :tag "matching" "emacs>=24.5"
;;   :url "https://github.com/abo-abo/swiper"
;;   :emacs>= 24.5
;;   :ensure t
;;   :blackout t
;;   :leaf-defer nil
;;   :custom ((ivy-initial-inputs-alist . nil)
;;            (ivy-use-selectable-prompt . t))
;;   :global-minor-mode t
;;   :config
;;   (leaf swiper
;;     :doc "Isearch with an overview. Oh, man!"
;;     :req "emacs-24.5" "ivy-0.13.0"
;;     :tag "matching" "emacs>=24.5"
;;     :url "https://github.com/abo-abo/swiper"
;;     :emacs>= 24.5
;;     :ensure t
;;     :bind (("C-s" . swiper)))
;; 
;;   (leaf counsel
;;     :doc "Various completion functions using Ivy"
;;     :req "emacs-24.5" "swiper-0.13.0"
;;     :tag "tools" "matching" "convenience" "emacs>=24.5"
;;     :url "https://github.com/abo-abo/swiper"
;;     :emacs>= 24.5
;;     :ensure t
;;     :blackout t
;;     :bind (("C-S-s" . counsel-imenu)
;;            ("C-x C-r" . counsel-recentf))
;;     :custom `((counsel-yank-pop-separator . "\n----------\n")
;;               (counsel-find-file-ignore-regexp . ,(rx-to-string '(or "./" "../") 'no-group)))
;;     :global-minor-mode t))
;; 
;; (leaf prescient
;;   :doc "Better sorting and filtering"
;;   :req "emacs-25.1"
;;   :tag "extensions" "emacs>=25.1"
;;   :url "https://github.com/raxod502/prescient.el"
;;   :emacs>= 25.1
;;   :ensure t
;;   :custom ((prescient-aggressive-file-save . t))
;;   :global-minor-mode prescient-persist-mode)
;;   
;; (leaf ivy-prescient
;;   :doc "prescient.el + Ivy"
;;   :req "emacs-25.1" "prescient-4.0" "ivy-0.11.0"
;;   :tag "extensions" "emacs>=25.1"
;;   :url "https://github.com/raxod502/prescient.el"
;;   :emacs>= 25.1
;;   :ensure t
;;   :after prescient ivy
;;   :custom ((ivy-prescient-retain-classic-highlighting . t))
;;   :global-minor-mode t)

;;; init.el ends here



;; (blink-cursor-mode 0)

;; (keyboard-translate ?\C-h ?\C-?)
;; (global-set-key "\C-h" nil)
;; ;; ヘルプの表示を M-? 変更
;; (define-key global-map "\M-?" 'help-for-help)

;; (setq mac-option-modifier 'super)

;; ;; ファイル名検索
;; (define-key global-map [(super i)] 'find-name-dired)
;; ;; ファイル内検索
;; (define-key global-map [(super f)] 'rgrep)


;; ;; cmd as meta for emacs-plus
;; (when (and (eq window-system 'ns)
;; 	   (eq system-type 'darwin)
;; 	   (display-graphic-p))
;;   (setq mac-option-modifier nil
;;         mac-command-modifier 'meta))

;; (progn
;;   (define-key global-map "\C-x\C-b" 'electric-buffer-list)
;;   (load-file "~/bs-h.el")
;;   ;;(load "bs-h")
;;   (require 'bs)
;;   (setq bs--show-all t)
;;   (setq bs-default-configuration "all")
;;   (define-key global-map "\C-x\C-b" 'bs-show))
