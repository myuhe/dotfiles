
(defun image-toggle-display-image ()
  "Show the image of the image file.
Turn the image data into a real image, but only if the whole file
was inserted."
  (unless (derived-mode-p 'image-mode)
    (error "The buffer is not in Image mode"))
  (let* ((filename (buffer-file-name))
         (data-p (not (and filename
                           (file-readable-p filename)
                           (not (file-remote-p filename))
                           (not (buffer-modified-p))
                           (not (and (boundp 'archive-superior-buffer)
                                     archive-superior-buffer))
                           (not (and (boundp 'tar-superior-buffer)
                                     tar-superior-buffer)))))
         (file-or-data (if data-p
                           (string-make-unibyte
                            (buffer-substring-no-properties (point-min) (point-max)))
                         filename))
         (type (image-type file-or-data nil data-p))
         (image (create-image file-or-data 'imagemagick data-p))
         (inhibit-read-only t)
         (buffer-undo-list t)
         (modified (buffer-modified-p))
         props)
    
    ;; Discard any stale image data before looking it up again.
    (image-flush image)
    (setq image (append image (image-transform-properties image)))
    (setq props
          `(display ,image
                    ;; intangible ,image
                    rear-nonsticky (display) ;; intangible
                    read-only t front-sticky (read-only)))
    
    (let ((buffer-file-truename nil)) ; avoid changing dir mtime by lock_file
      (add-text-properties (point-min) (point-max) props)
      (restore-buffer-modified-p modified))
    ;; Inhibit the cursor when the buffer contains only an image,
    ;; because cursors look very strange on top of images.
    (setq cursor-type nil)
    ;; This just makes the arrow displayed in the right fringe
    ;; area look correct when the image is wider than the window.
    (setq truncate-lines t)
    ;; Disable adding a newline at the end of the image file when it
    ;; is written with, e.g., C-x C-w.
    (if (coding-system-equal (coding-system-base buffer-file-coding-system)
                             'no-conversion)
        
        (setq-local find-file-literally t))
    ;; Allow navigation of large images.
    (setq-local auto-hscroll-mode nil)
    (setq image-type type)
    (if (eq major-mode 'image-mode)
        (setq mode-name (format "Image[%s]" type)))
    (image-transform-check-size)
    (if (called-interactively-p 'any)
        (message "Repeat this command to go back to displaying the file as text"))))

(provide 'init-image-mode)
