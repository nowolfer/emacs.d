;; (when (maybe-require-package 'elm-mode)
;;   (after-load 'auto-complete
;;     (add-to-list 'ac-modes 'elm-mode))
;;   (after-load 'elm-mode
;;     (when (executable-find "elm-oracle")
;;       (add-hook 'elm-mode-hook 'elm-oracle-setup-ac)))
;;   (when (maybe-require-package 'flycheck-elm)
;;     (after-load 'elm-mode
;;       (flycheck-elm-setup))))

;; (provide 'init-elm)


(when (maybe-require-package 'elm-mode)
  (after-load 'elm-mode
    (diminish 'elm-indent-mode)
    (when (executable-find "elm-oracle")
      (add-hook 'elm-mode-hook 'elm-oracle-setup-completion))
    (when (executable-find "elm-format")
      (setq-default elm-format-on-save t)))
  (when (maybe-require-package 'flycheck-elm)
    (after-load 'elm-mode
      (flycheck-elm-setup))))

(provide 'init-elm)
