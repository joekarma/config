;;;; config.lisp

(in-package #:config)

(defun get-configurations-directory ()
  (ensure-directories-exist
   (merge-pathnames ".config/common-lisp/" (user-homedir-pathname))))

(defun list-configuration-files ()
  (let ((configuration-files '()))
    (fad:walk-directory (get-configurations-directory)
                        (lambda (f)
                          (when (string= (pathname-type f)
                                         "conf")
                            (push f configuration-files))))
    configuration-files))

(defun get-configuration-file-path (system)
  (merge-pathnames (make-pathname :name (string-downcase (string system)) :type "conf")
                   (get-configurations-directory)))

(defun make-configuration-file (system &optional configurations-alist)
  (let ((path (get-configuration-file-path system))
        (*print-pretty* t))
    (alexandria:write-string-into-file (write-to-string configurations-alist) path)))

(defun set-configuration (system key value)
  (let ((config (get-configuration system)))
    (setf config (delete-if (alexandria:curry #'eql key) config :key #'car))
    (alexandria:write-string-into-file (write-to-string (cons (cons key value) config))
                                       (get-configuration-file-path system)
                                       :if-exists :overwrite)))

(defun get-configuration (system &optional key)
  (with-open-file (config (get-configuration-file-path system))
    (let ((result (read config)))
      (if key
          (alexandria:assoc-value result key)
          result))))

(defun delete-configuration-file (system)
  (ignore-errors
    (delete-file (get-configuration-file-path system))))


