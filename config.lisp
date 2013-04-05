;;;; config.lisp

(in-package #:config)

(defun get-configurations-directory ()
  (ensure-directories-exist
   (merge-pathnames ".config/common-lisp/" (user-homedir-pathname))))

(defun get-configuration-file-path (system)
  (merge-pathnames (make-pathname :name (string-downcase (string system)) :type "conf")
                   (get-configurations-directory)))

(defun make-configuration-file (system &optional configurations-alist)
  (let ((path (get-configuration-file-path system))
        (*print-pretty* t))
    (alexandria:write-string-into-file (write-to-string configurations-alist) path)))

(defun get-configuration (system &optional key)
  (with-open-file (config (get-configuration-file-path system))
    (let ((result (read config)))
      (if key
          (alexandria:assoc-value result key)
          result))))
