Config
======

This is a simple project for creating and accessing configuration
files that are stored in `~/.config/common-lisp/`

Idea is to create configuration files for Quicklisp projects,
i.e. `(config:make-configuration-file :my-web-project)`. These files
could store important information like usernames and passwords for
database connections.