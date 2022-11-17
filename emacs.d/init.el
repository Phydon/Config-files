;; Don't show the welcome screen
(setq inhibit-startup-message t)

;; Turn off UI elements
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; (menu-bar-mode -1)

;; Display relative line numbers in every buffer
;; (global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; Theme
(load-theme 'tango-dark t)

;; Remember and restore the last cursor location of opened files
(save-place-mode 1)

;; Don`t pop up UI dialogs when prompting
(setq use-dialog-box nil)

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

;; Revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; show completions in find-file
(ido-mode 1)

;; open the config file
(global-set-key (kbd "M-w") (lambda() (interactive)(find-file "~/Appdata/Roaming/.emacs.d/init.el")))


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(require 'evil)
(evil-mode 1)

(require 'evil-multiedit)
(evil-multiedit-default-keybinds)

;; EVIL
;; set leader key in normal state
(evil-set-leader 'normal (kbd "SPC"))
;; set leader key bindings 
(evil-define-key 'normal 'global (kbd "<leader>b") 'list-buffers)
(evil-define-key 'normal 'global (kbd "<leader>f") 'find-file)
(evil-define-key 'normal 'global (kbd "<leader>t") 'eshell)
(evil-define-key 'normal 'global (kbd "<leader>ww") '(lambda() (interactive)(find-file "~/obsidian_vault/quicknotes.md")))

;; vim surround
(use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode 1))

;; vim commentary
(evil-commentary-mode)


;; SMEX
;; show completions for M-x
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; to get the old M-x
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack NF" :foundry "outline" :slant normal :weight normal :height 143 :width normal)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-multiedit deadgrep smex evil-commentary use-package evil)))
