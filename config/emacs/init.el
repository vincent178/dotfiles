(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;; PACKAGES
(straight-use-package 'counsel)

(straight-use-package '(evil :type git :host github 
                             :repo "emacs-evil/evil"))

(straight-use-package '(minibuffer :type git :host github
                                   :repo "muffinmad/emacs-mini-frame"))

(straight-use-package '(projectile :type git :host github
                                   :repo "bbatsov/projectile"))

(straight-use-package '(ivy :type git :host github
                            :repo "abo-abo/swiper"))

(straight-use-package '(magit :type git :host github
                              :repo "magit/magit"))

(straight-use-package '(lsp-mode :type git :host github
                                 :repo "emacs-lsp/lsp-mode"))

(straight-use-package '(go-mode :type git :host github 
                                :repo "dominikh/go-mode.el"))

(straight-use-package '(which-key :type git :host github 
                                  :repo "justbur/emacs-which-key"))

(straight-use-package '(company :type git :host github 
                                :repo "company-mode/company-mode"))

(straight-use-package '(nano-agenda :build (:not compile) :type git :host github 
                                    :repo "rougier/nano-agenda"))

(straight-use-package '(nano-theme :build (:not compile) :type git :host github 
                                   :repo "rougier/nano-theme"))

(straight-use-package '(elegant :build (:not compile) :type git :host github 
                                :repo "rougier/elegant-emacs"))

;;; GENERAL
(let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path 
        (append
         (split-string-and-unquote path ":")
         exec-path)))

;;; CONFIGURATIONS
(setq x-select-enable-clipboard nil)
(setq evil-want-C-u-scroll t)
(setq evil-mode-line-format nil)
(require 'evil)
(evil-mode 1)

(require 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(require 'magit)

(require 'which-key)
(which-key-mode)

(require 'project)

(defun project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))

(add-hook 'project-find-functions #'project-find-go-module)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(require 'go-mode)
(require 'lsp-mode)
(add-hook 'go-mode-hook #'lsp-deferred)
;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(require 'sanity)
(require 'nano-theme)
(nano-mode)
(nano-dark)
(require 'nano-agenda)

;;; ORG MODE
(setq org-directory "~/Org")
(setq org-agenda-files (list "inbox.org"))

(setq org-capture-templates
       `(("i" "Inbox" entry  (file "inbox.org")
        ,(concat "* TODO %?\n"
                 "  /Entered on/ %U"))))

(define-key global-map (kbd "C-c c") 'org-capture)

(defun org-capture-inbox ()
     (interactive)
     (call-interactively 'org-store-link)
     (org-capture nil "i"))

(define-key global-map (kbd "C-c i") 'org-capture-inbox)

(define-key global-map (kbd "C-c a") 'org-agenda)

(setq org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t% s")
        (todo   . " ")
        (tags   . " %i %-12:c")
        (search . " %i %-12:c")))

(setq org-agenda-files (list "inbox.org" "agenda.org"))

(setq org-agenda-files 
      (mapcar 'file-truename 
          (file-expand-wildcards "~/Org/*.org")))

;; Save the corresponding buffers
(defun gtd-save-org-buffers ()
  "Save `org-agenda-files' buffers without user confirmation.
See also `org-save-all-org-buffers'"
  (interactive)
  (message "Saving org-agenda-files buffers...")
  (save-some-buffers t (lambda () 
             (when (member (buffer-file-name) org-agenda-files) 
               t)))
  (message "Saving org-agenda-files buffers... done"))

;; Add it after refile
(advice-add 'org-refile :after
        (lambda (&rest _)
          (gtd-save-org-buffers)))

