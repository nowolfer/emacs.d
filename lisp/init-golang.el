;; (setq auto-mode-alist
;;       (append '(("SConstruct\\'" . go-mode)
;;                 "SConscript\\'" . go-mode)
;;               auto-mode-alist))


(require-package 'go-mode)
(require-package 'go-eldoc)

(defun go-mode-setup ()
  (go-eldoc-setup)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'go-mode-setup)

(provide 'init-golang)
