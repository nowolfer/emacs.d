;; (setq auto-mode-alist
;;       (append '(("SConstruct\\'" . go-mode)
;;                 "SConscript\\'" . go-mode)
;;               auto-mode-alist))

(add-to-list 'load-path (concat (getenv "GOPATH")  "/src/github.com/golang/lint/misc/emacs"))
(require-package 'golint)
(require-package 'go-mode)
(require-package 'go-eldoc)
(require-package 'go-autocomplete)

;;
(defun go-mode-setup ()
  (setq compile-command "go build -v && go test -v && go vet && golint")
  (define-key (current-local-map) "\C-c\C-c" 'compile)
  (go-eldoc-setup)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook '(lambda ()
                           (local-set-key (kbd "C-c C-f ") 'gofmt)))
(add-hook 'go-mode-hook 'go-mode-setup)

(provide 'init-golang)
