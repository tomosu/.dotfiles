; M-x eval-buffer install_packs.el


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(package-refresh-contents)

(defvar my/favorite-packages
  '(
    auto-complete auto-complete-c-headers auto-complete-etags popup
    company concurrent ctable deferred flymake flymake-easy flymake-python-pyflakes
    jedi jedi-core company-jedi epc python-environment
    )
  )


(dolist (package my/favorite-packages)
  (unless (package-installed-p package)
    (package-install package)))
