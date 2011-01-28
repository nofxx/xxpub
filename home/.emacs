;;
;; User
(setq user-full-name "nofxx")
(setq user-mail-address "user@user.com")
(setq visible-bell t)
(defalias 'yes-or-no-p 'y-or-n-p)

;; disable line wrap
(setq default-truncate-lines t)

;; make side by side buffers function the same as the main window
(setq truncate-partial-width-windows nil)

;; Add F12 to toggle line wrap
(global-set-key [f12] 'toggle-truncate-lines)

(prefer-coding-system 'utf-8)
;;(setq c-basic-offset 2)
;;(setq tab-width 2)
(setq indent-tabs-mode nil)
(setq-default tab-width 2) ; or any other preferred value

;;
;; Load Path
(setq load-path
        (append (list nil "~/.emacs.d"
                         "~/.emacs.d/includes"
                         "~/.emacs.d/includes/color-theme"
                         "~/.emacs.d/includes/rinari"
                         "~/.emacs.d/includes/rinari/rhtml"
                         "~/.emacs.d/includes/emacs-rails"
                         "~/.emacs.d/includes/eieio"
                         "~/.emacs.d/includes/semantic"
                         "~/.emacs.d/includes/speedbar"
                         "~/.emacs.d/includes/jump.el")
                         load-path))

;;
;; SO Detection
(setq macosx-p (string-match "darwin" (symbol-name system-type)))
(setq linux-p (string-match "linux" (symbol-name system-type)))
(if macosx-p   (load-file "~/.emacs.d/osx.el"))
(if linux-p    (load-file "~/.emacs.d/linux.el"))

;;
;; Color Theme and fonts
(require 'color-theme)
(color-theme-initialize)
(color-theme-twilight)
;(color-theme-arjen)
(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings 'meta))

;;
;; YAS
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")
(setq yas/window-system-popup-function 'yas/x-popup-menu-for-template)

;;
;; Ruby
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(setq auto-mode-alist  (cons '(".rb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '(".erb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '(".god$" . ruby-mode) auto-mode-alist))


(add-hook 'ruby-mode-hook
  (lambda()
    (add-hook 'local-write-file-hooks
      '(lambda()
        (save-excursion
              (untabify (point-min) (point-max))
              (delete-trailing-whitespace)
                )
          )
        )
        (set (make-local-variable 'indent-tabs-mode) 'nil)
        (set (make-local-variable 'tab-width) 2)
        (imenu-add-to-menubar "IMENU")
        (define-key ruby-mode-map "\C-m" 'newline-and-indent)
        (require 'ruby-electric)
        (ruby-electric-mode t)
  )
)

;; Part of the Emacs Starter Kit
(eval-after-load 'ruby-mode
  '(progn
;;     (require 'ruby-compilation)
     (setq ruby-use-encoding-map nil)
     (add-hook 'ruby-mode-hook 'inf-ruby-keys)
     (define-key ruby-mode-map (kbd "RET") 'reindent-then-newline-and-indent)
     (define-key ruby-mode-map (kbd "C-M-h") 'backward-kill-word)
     (define-key ruby-mode-map (kbd "C-c l") "lambda")))

(global-set-key (kbd "C-h r") 'ri)

;; Rake files are ruby, too, as are gemspecs.
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))

;; We never want to edit Rubinius bytecode
(add-to-list 'completion-ignored-extensions ".rbc")

;;; Rake
(defun pcomplete/rake ()
  "Completion rules for the `ssh' command."
  (pcomplete-here (pcmpl-rake-tasks)))

(defun pcmpl-rake-tasks ()
   "Return a list of all the rake tasks defined in the current
projects. I know this is a hack to put all the logic in the
exec-to-string command, but it works and seems fast"
   (delq nil (mapcar '(lambda(line)
      (if (string-match "rake \\([^ ]+\\)" line) (match-string 1 line)))
     (split-string (shell-command-to-string "rake -T") "[\n]"))))

(defun rake (task)
  (interactive (list (completing-read "Rake (default: default): "
                                      (pcmpl-rake-tasks))))
  (shell-command-to-string (concat "rake " (if (= 0 (length task)) "default" task))))


;; Clear the compilation buffer between test runs.
;;(eval-after-load 'ruby-compilation
;;  '(progn
;;     (defadvice ruby-do-run-w/compilation (before kill-buffer (name cmdlist))
;;       (let ((comp-buffer-name (format "*%s*" name)))
;;         (when (get-buffer comp-buffer-name)
;;           (with-current-buffer comp-buffer-name
;;             (delete-region (point-min) (point-max))))))
;;     (ad-activate 'ruby-do-run-w/compilation)))

(add-hook 'ruby-mode-hook 'coding-hook)

;;; Flymake

;; (eval-after-load 'ruby-mode
;;   '(progn
;;      (require 'flymake)

;;      ;; Invoke ruby with '-c' to get syntax checking
;;      (defun flymake-ruby-init ()
;;        (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                           'flymake-create-temp-inplace))
;;               (local-file (file-relative-name
;;                            temp-file
;;                            (file-name-directory buffer-file-name))))
;;          (list "ruby" (list "-c" local-file))))

;;      (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
;;      (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

;;      (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3)
;;            flymake-err-line-patterns)

;;      (add-hook 'ruby-mode-hook
;;                (lambda ()
;;                  (when (and buffer-file-name
;;                             (file-writable-p
;;                              (file-name-directory buffer-file-name))
;;                             (file-writable-p buffer-file-name))
;;                    (local-set-key (kbd "C-c d")
;;                                   'flymake-display-err-menu-for-current-line)
;;                    (flymake-mode t))))))


;; TODO: set up ri
;; TODO: electric

(provide 'starter-kit-ruby)
;; starter-kit-ruby.el ends here

; YAML Mode
(autoload 'yaml-mode "yaml-mode" "Major mode for editing yaml files." t)
(setq auto-mode-alist  (cons '(".yml$" . yaml-mode) auto-mode-alist))

;;
;; Emacs-Rails
(load "snippet")
(load "find-recursive")
(require 'rails)

; Rinari (RAILS) Configurações
(require 'rinari)
(setq rinari-tags-file-name "TAGS")

; IDO Interactively Do Things
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ;; Use it for many file dialogs
      ido-everywhere t
      ;; Don’t be case sensitive
      ido-case-fold t)
      ;; If the file at point exists, use that
      ;;ido-use-filename-at-point t)
      ;; Or if it is an URL…
      ;;ido-use-url-at-point t
      ;; Even if TAB completes uniquely,
      ;; still wait for RET
      ;;ido-confirm-unique-completion t)
      ;; If the input does not exist,
      ;; don’t look in unexpected places.
      ;; I probably want a new file.
      ;;ido-auto-merge-work-directories-length -3)


;; rhtml mode
(add-to-list 'load-path "~/.emacs.d/includes/rhtml-mode")
(require 'rhtml-mode)

(setq semantic-load-turn-everything-on t)
(require 'semantic-load)

(require 'textile-mode)
(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(display-time-mode t)
 '(flymake-js-off t)
 '(inhibit-startup-screen t)
 '(fset 'yes-or-no-p 'y-or-n-p)
 '(menu-bar-mode nil)
 '(scroll-bar-mode (quote right))
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
 ;'(twit-pass "")
 ;'(twit-user ""))

(require 'paren) (show-paren-mode t)

; Configurando o sistema de backup do Emacs
(setq backup-by-copying t               ; don't clobber symlinks
      backup-directory-alist
      '(("." . "~/.emacs.d/backups"))      ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
(add-hook 'ruby-mode-hook
          '(lambda ()
             (make-variable-buffer-local 'yas/trigger-key)
             (setq yas/trigger-key [tab])))

;; Tabbar
(require 'tabbar)
(tabbar-mode)
  (autoload 'mode-compile "mode-compile"
   "Command to compile current buffer file based on the major mode" t)
  (global-set-key "\C-cc" 'mode-compile)
  (global-set-key "\C-cr" 'mode-compile)
  (autoload 'mode-compile-kill "mode-compile"
   "Command to kill a compilation launched by `mode-compile'" t)
  (global-set-key "\C-ck" 'mode-compile-kill)


;; Linum
(require 'linum)
(global-linum-mode)

;;
;; HAML & SASS
(require 'haml-mode nil 't)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))
(require 'sass-mode)
;;(eval-after-load 'haml-mode
;;(if (functionp 'whitespace-mode)
;;   (add-hook 'haml-mode-hook 'whitespace-mode)))

;;
;; Rspec & Friends
(require 'rspec-mode)
(require 'cucumber-mode)
(add-to-list 'load-path "~/.emacs.d/snippets/feature-mode")
(autoload 'feature-mode "feature-mode" "Mode for editing cucumber files" t)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

(defun autotest ()
(interactive)
(let ((buffer (shell "autotest")))
(comint-send-string buffer "autotest\n")))

(defun autotest-switch ()
(interactive)
(if (equal "autotest" (buffer-name))
(previous-buffer)
(switch-to-buffer "autotest")))
; add to ruby mode hook:
(define-key ruby-mode-map "\C-c\C-s" 'autotest-switch)

;; GIT
(require 'magit)
(require 'gist)

;; Markdown
;;
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\\.md" . markdown-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))

;; CSS
;;
(autoload 'css-mode "css-mode" "Major mode for editing css files." t)
(setq auto-mode-alist  (cons '(".css$" . css-mode) auto-mode-alist))

;; JavaScript
;;
;;(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
(autoload 'espresso-mode "espresso" nil t)

;; Coffee-Script
;;
;; http://github.com/defunkt/coffee-mode.git
(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;; Findr!
;;
(autoload 'findr "findr" "Find file name." t)
(define-key global-map [(meta control S)] 'findr)

(autoload 'findr-search "findr" "Find text in files." t)
(define-key global-map [(meta control s)] 'findr-search)

(autoload 'findr-query-replace "findr" "Replace text in files." t)
(define-key global-map [(meta control r)] 'findr-query-replace)

;(define-key shell-mode-map "\C-c\C-a" 'autotest-switch)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq cua-auto-tabify-rectangles nil)

(defadvice align (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice align-regexp (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defadvice indent-relative (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))

(defmacro smart-tabs-advice (function offset)
  (defvaralias offset 'tab-width)
  `(defadvice ,function (around smart-tabs activate)
     (cond
      (indent-tabs-mode
       (save-excursion
         (beginning-of-line)
         (while (looking-at "\t*\\( +\\)\t+")
           (replace-match "" nil nil nil 1)))
       (setq tab-width tab-width)
       (let ((tab-width fill-column)
             (,offset fill-column))
         ad-do-it))
      (t
       ad-do-it))))

(smart-tabs-advice c-indent-line c-basic-offset)
(smart-tabs-advice c-indent-region c-basic-offset)

(smart-tabs-advice vhdl-indent-line vhdl-basic-offset)
(setq vhdl-indent-tabs-mode t)

(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(require 'lua-mode)

;;(add-hook 'espresso-mode-hook 'espresso-custom-setup)
;;(defun espresso-custom-setup ()
  (moz-minor-mode 1);;)

;;
;; Textmate goods
;; from http://github.com/topfunky/emacs-starter-kit
(defun textmate-next-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))
(defun textmate-previous-line ()
  (interactive)
  (beginning-of-line)
  (newline-and-indent)
  (previous-line)
  (indent-according-to-mode))

(setq auto-mode-alist (append
  '(("\\.cu$" . c++-mode))
   auto-mode-alist))

(setq auto-mode-alist (append
  '(("\\.pde$" . c++-mode))
   auto-mode-alist))

(global-set-key "\C-x\C-g" 'magit-status)
(global-set-key "\M-/" 'comment-or-uncomment-region)
(global-set-key "\M-[" 'indent-region)
(global-set-key "\M-]" 'indent-according-to-mode)
(global-set-key "\M-s" 'save-buffer)
(global-set-key "\M-t" 'ido-find-file)
(global-set-key "\M-q" 'kill-this-buffer)
(global-set-key "\M-a" 'magit-status)
(global-set-key "\M-r" 'query-replace)
(global-set-key "\M-w" 'ido-switch-buffer)

(global-set-key "\M-1" 'list-buffers)
(global-set-key "\M-2" 'bookmark-bmenu-list)

(global-set-key [M-return] 'textmate-next-line)
(global-set-key [C-return] 'textmate-previous-line)

(global-set-key [f9] 'recompile)
(global-set-key [f11] 'compile)