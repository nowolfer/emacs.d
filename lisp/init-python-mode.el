(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
                ("SConscript\\'" . python-mode))
              auto-mode-alist))

;;; Elpy python IDE (https://elpy.readthedocs.org/en/latest/index.html)
;;; Require Flake8 (https://flake8.readthedocs.org/en/latest/index.html) Note: using pip
;;;         JEDI (http://jedi.jedidjah.ch/en/latest/)                    Note: using pip
;;;         Autopep8 (https://pypi.python.org/pypi/autopep8/)            Note: using pip
(require-package 'py-autopep8)
(require-package 'flycheck)
(require-package 'elpy)
(require-package 'pip-requirements)
                                        ;(require-package 'py-autopep8)
;;; Elpy activate
(elpy-enable)
;;;(elpy-use-ipython)
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(when (require 'py-autopep8 nil t)
  (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save))

(provide 'init-python-mode)
