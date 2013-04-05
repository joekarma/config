;;;; package.lisp

(defpackage #:config
  (:use #:cl)
  (:export
   #:get-configuration
   #:make-configuration-file
   #:get-configuration-file-path
   #:get-configurations-directory
   #:list-configuration-files
   #:set-configuration))

