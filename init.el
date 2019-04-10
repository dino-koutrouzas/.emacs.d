; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; list the packages you want
(setq package-list '(better-defaults
                     base16-theme
                     helm
                     helm-projectile
                     helm-ag
                     ruby-electric
                     seeing-is-believing
                     rbenv
                     inf-ruby
                     ruby-test-mode
                     rubocop
                     rinari
                     exec-path-from-shell
                     web-mode
                     auto-complete
                     magit
                     git-gutter+
                     git-gutter-fringe+
                     rust-mode
                     writeroom-mode))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'better-defaults)

(global-git-gutter+-mode)
(require 'git-gutter-fringe+)

(setq writeroom-major-modes '(text-mode ruby-mode))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(setq auto-save-file-name-transforms
                `((".*" ,(concat user-emacs-directory "auto-save/") t))) 

(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'ruby-mode)

(setq ruby-insert-encoding-magic-comment nil)

(setq next-line-add-newlines t)

(load-theme 'base16-eighties t)

(setq visible-bell nil)

;; Typography
(set-face-attribute 'default nil
                    :family "Menlo"
                    :height 150
                    :weight 'normal
                    :width 'normal)
(setq-default line-spacing 4)

(global-hl-line-mode 1)

(require 'helm)
(require 'helm-projectile)
(require 'helm-ag)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "s-f") #'helm-projectile-ag)
(global-set-key (kbd "s-t") #'helm-projectile-find-file)

;; Allow hash to be entered  
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;; Autoclose paired syntax elements like parens, quotes, etc
(require 'ruby-electric)
(add-hook 'ruby-mode-hook 'ruby-electric-mode)
(global-rbenv-mode)
(rbenv-use-global)

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

(ac-config-default)
(setq web-mode-ac-sources-alist
  '(("css" . (ac-source-css-property))
    ("html" . (ac-source-words-in-buffer ac-source-abbrev))))

(defun web-mode-indent ()
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-code-indent-offset 2)
    (setq web-mode-indent-style 2)
)
(add-hook 'web-mode-hook  'web-mode-indent)
(setq-default indent-tabs-mode nil)

(setq seeing-is-believing-prefix "C-.")
(add-hook 'ruby-mode-hook 'seeing-is-believing)
(require 'seeing-is-believing)

(add-hook 'ruby-mode-hook #'rubocop-mode)

(autoload 'inf-ruby-minor-mode "inf-ruby" "Run an inferior Ruby process" t)
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)

(require 'ruby-test-mode)
(add-hook 'ruby-mode-hook 'ruby-test-mode)

(require 'rinari)
(global-rinari-mode)
(require 'ido)
(ido-mode t)

(global-set-key (kbd "C-x g") 'magit-status)

(add-hook 'compilation-finish-functions
          (lambda (buf strg)
            (switch-to-buffer-other-window "*compilation*")
            (read-only-mode)
            (goto-char (point-max))
            (local-set-key (kbd "q")
(lambda () (interactive) (quit-restore-window)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (writeroom-mode rust-mode magit solarized-theme seeing-is-believing ruby-test-mode ruby-electric rbenv inf-ruby helm-projectile helm-ag better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:background "#515151" :foreground "#a09f93" :box nil)))))
(put 'downcase-region 'disabled nil)
