; Setup package.el and add MELPA repository
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install 'use-package' if not already installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))


;; Load 'use-package'
(eval-when-compile
  (require 'use-package))


;; install magit if not exist
(unless (package-installed-p 'magit)
  (package-refresh-contents)
  (package-install 'magit))


;; remove major and minor modes from mode line
(diminish 'projectile-mode)


;; ace-window for faster window movement
(unless (package-installed-p 'ace-window)
  (package-refresh-contents)
  (package-install 'ace-window))


;; which-key
(unless (package-installed-p 'which-key)
  (package-refresh-contents)
  (package-install 'which-key))

;; enable which-key mode
(which-key-mode)


;; dump-jump
(use-package dumb-jump
  :ensure t
  :init (dumb-jump-mode)
  :config (setq dumb-jump-selector 'ivy)  ;; or 'helm, 'ido
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g b" . dumb-jump-back)))

(setq dumb-jump-force-searcher 'rg)
;;(setq dumb-jump-default-project "~/src/firespotter/common/")


;; company mode
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0.2) ; Delay before suggestions pop up, in seconds
(setq company-minimum-prefix-length 1) ; Minimum prefix length for suggestions
(setq company-tooltip-limit 10) ; Maximum number of suggestions to display

;; org mode
(require 'org)

;; Set the directory for Org files
(setq org-directory "~/org")

;; Specify the location of your todo file
(setq org-agenda-files (list "~/org/todos.org"))

;; Key binding for viewing the Org agenda
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
;;(global-set-key (kbd "C-c l") #'org-store-link)

;; Basic todo entry template
(setq org-capture-templates
      '(("t" "Todo" entry (file "~/org/todos.org")
         "* TODO %?\n  %u")))


;; use ace-window to switch window
(global-set-key (kbd "M-o") 'ace-window)

;; faster switch to buffer
(global-set-key (kbd "C-;") 'switch-to-buffer)


;;change font
;;(set-frame-font "Fira Mono for Powerline-20" nil t)
(set-frame-font "Inconsolata for Powerline-17" nil t)


; load jblow theme...
(load-theme 'naysayer t)
; set font size
;;
;;(set-face-attribute 'default nil :height 160)



;;(set-frame-font "Fira Sans" nil t)
(setq comint-process-echoes 0)

; to follow symlinks
(setq vc-follow-symlinks t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;(setq display-line-numbers-type 'relative)
;;(global-display-line-numbers-mode)
(setq column-number-mode t)


(recentf-mode 1)
(setq recentf-max-menu-items 25) ;; Set the number of recent files to show (optional)

(delete-selection-mode 1)

;; let emacs ask to exit
(setq confirm-kill-emacs 'y-or-n-p)

;; disable backup files #
(setq make-backup-files nil)

;; Require python mode
(require 'python)

;; Set up Python mode
;;(autoload 'python-mode "python-mode" "Python Mode." t)
;;(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;;(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; Use spaces for indentation in Python mode
(setq-default indent-tabs-mode nil)

;; Set the number of spaces per indentation level (customize as needed)
(setq-default python-indent-offset 2)

;; Enable `python-mode' for `.py' files
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

;; Automatically indent using the configured offset
(defun my-python-mode-hook ()
  (setq indent-tabs-mode nil)
  (setq python-indent-offset 2))
(add-hook 'python-mode-hook 'my-python-mode-hook)


;; Set the Python interpreter path
;;(setq python-shell-interpreter "/Users/onurozer/.pyenv/versions/3.9.18/envs/ubervoice3-unit-venv/bin/python")

(defface font-lock-keyword-onur-face
  '((t (:foreground "#59ecff")))
  "Face for highlighting custom keywords."
  :group 'my-faces)

(add-hook 'python-mode-hook
          (lambda ()
            (font-lock-add-keywords
             nil
             '(("\\<\\(def\\)\\>"
                1 'font-lock-keyword-onur-face)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("375a3611e04b912ff797dc11ddb219043f0a058f5449b50fb815d3bbf6697d8e" "9c7b478676c63690c9bba8f1e51100065ac6cc5652af6839db936ace353a666f" "3b924ae4fd0bdb23257773de22a16e8026da8221486e098052c771341460e369" "924a4ad7f22647f46601b340bab24b68f5a151559e6f2fc2a38acc94bc11e34c" "28d17e375be62fb0a16c4d0e1717e4523eddc8968497e9928a734ca13ec6382f" "18d1131ad6ff8e8e34287d6de9299faba4f1b03874278463fb6f38e3abe65bdc" default))
 '(package-selected-packages
   '(which-key vterm dumb-jump ace-window corfu diminish deadgrep naysayer-theme ivy-hydra swiper-helm counsel ivy projectile elpy)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; show current file path
(setq-default mode-line-buffer-identification
              (list (propertized-buffer-identification "%12f")))

; ivy, swiper and counsel
(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)


;;(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
;;(global-set-key (kbd "C-c qf") 'counsel-rg)
;;(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)


;; DEADGREP
(global-set-key (kbd "C-c f") #'deadgrep)
;; look only py files for deadgrep searches
(defvar-local deadgrep--file-type '(type . "py"))

;; prevent pressing ESC ESC ESC from closing second window when splitted
(global-unset-key (kbd "ESC ESC ESC"))

;; disable emacs BEEP sound
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

;; disable auto backup files which starts with ~
(setq make-backup-files nil)

;; set TAG file path for xref
(setq tags-file-name "/Users/onurozer/Desktop/emacs-tag/TAGS")
;; case sensitive TAG search with xref
(setq tags-case-fold-search nil)

;; magit performance increase
(setq magit-log-section-commit-count 30)
(setq gc-cons-threshold (* 100 1024 1024)) ;; 100MB
(setq magit-refresh-status-delay 0.5)

;; delete trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; add new lines at the end of buffer whwn you press C-n
(setq next-line-add-newlines t)
