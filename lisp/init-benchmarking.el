(defun linden/time-subtract-millis (b a)
  (* 1000.0 (float-time (time-subtract b a))))


(defvar linden/require-times nil
  "A list of (FEATURE . LOAD-DURATION).
LOAD-DURATION is the time taken in milliseconds to load FEATURE.")

(defadvice require (around linden/build-require-times (feature &optional filename noerror) activate)
  "Note in `linden/require-times' the time taken to require each feature."
  (let* ((already-loaded (memq feature features))
         (require-start-time (and (not already-loaded) (current-time))))
    (prog1
        ad-do-it
      (when (and (not already-loaded) (memq feature features))
        (let ((time (linden/time-subtract-millis (current-time) require-start-time)))
          (add-to-list 'linden/require-times
                       (cons feature time)
                       t))))))

(defun linden/show-init-time ()
  (message "init completed in %.2fms"
           (linden/time-subtract-millis after-init-time before-init-time)))

(add-hook 'after-init-hook 'linden/show-init-time)

(provide 'init-benchmarking)
