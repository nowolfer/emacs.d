(setq scheme-program-name "csi -:c")

(require 'cmuscheme)

(define-key scheme-mode-map "\C-c\C-l" 'scheme-load-current-file)
(define-key scheme-mode-map "\C-c\C-k" 'scheme-compile-current-file)

(defun scheme-load-current-file (&optional switch)
  (interactive "P")
  (let ((file-name (buffer-file-name)))
    (comint-check-source file-name)
    (setq scheme-prev-l/c-dir/file (cons (file-name-directory    file-name)
                                         (file-name-nondirectory file-name)))
    (comint-send-string (scheme-proc) (concat "(load \""
                                              file-name
                                              "\"\)\n"))
    (if switch
        (switch-to-scheme t)
      (message "\"%s\" loaded." file-name) ) ) )

(defun scheme-compile-current-file (&optional switch)
  (interactive "P")
  (let ((file-name (buffer-file-name)))
    (comint-check-source file-name)
    (setq scheme-prev-l/c-dir/file (cons (file-name-directory    file-name)
                                         (file-name-nondirectory file-name)))
    (message "compiling \"%s\" ..." file-name)
    (comint-send-string (scheme-proc) (concat "(compile-file \""
                                              file-name
                                              "\"\)\n"))
    (if switch
        (switch-to-scheme t)
      (message "\"%s\" compiled and loaded." file-name) ) ) )

;; Indenting module body code at column 0
(defun scheme-module-indent (state indent-point normal-indent) 0)
(put 'module 'scheme-indent-function 'scheme-module-indent)

(put 'and-let* 'scheme-indent-function 1)
(put 'parameterize 'scheme-indent-function 1)
(put 'handle-exceptions 'scheme-indent-function 1)
(put 'when 'scheme-indent-function 1)
(put 'unless 'scheme-indent-function 1)
(put 'match 'scheme-indent-function 1)

(require 'autoinsert)
(add-hook 'find-file-hooks 'auto-insert)

(setq auto-insert-alist
      '(("\\.scm" .
         (insert "#!/bin/sh\n#| -*- scheme -*-\nexec csi -s $0 \"$@\"\n|#\n"))))

(provide 'init-scheme)
