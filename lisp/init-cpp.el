;; config for C++ and CUDA

(require-package 'cuda-mode)
(add-to-list 'auto-mode-alist '("\\.cu\\'" . cuda-mode))

(require 'ccls)
(setq ccls-executable "/usr/bin/ccls")

(require-package 'use-package)
(use-package lsp-mode :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)

(use-package ccls
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp))))

(defun ccls/callee ()
  (interactive)
  (lsp-ui-peek-find-custom "$ccls/call" '(:callee t)))
(defun ccls/caller ()
  (interactive)
  (lsp-ui-peek-find-custom "$ccls/call"))
(defun ccls/vars (kind)
  (interactive "nField (1); Local Variable (2); Field or Local Variable (3); Parameter (4). Select:")
  (lsp-ui-peek-find-custom "$ccls/vars" `(:kind ,kind)))
(defun ccls/base (levels)
  (interactive "nDirect bases (1). Levels:")
  (lsp-ui-peek-find-custom "$ccls/inheritance" `(:levels ,levels)))
(defun ccls/derived (levels)
  (interactive "nDirect derived (1). Levels:")
  (lsp-ui-peek-find-custom "$ccls/inheritance" `(:levels ,levels :derived t)))
(defun ccls/member (kind)
  (interactive "nNested classes / types in a namespace (2); Member functions / functions in a namespace (3); Member variables / variables in a namespace (0). Select: ")
  (lsp-ui-peek-find-custom "$ccls/member" `(:kind ,kind)))

;; References w/ Role::Role
(defun ccls/references-read ()
  (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
                           (plist-put (lsp--text-document-position-params) :role 8)))

;; References w/ Role::Write
(defun ccls/references-write ()
  (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
                           (plist-put (lsp--text-document-position-params) :role 16)))

;; References w/ Role::Dynamic bit (macro expansions)
(defun ccls/references-macro ()
  (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
                           (plist-put (lsp--text-document-position-params) :role 64)))

;; References w/o Role::Call bit (e.g. where functions are taken addresses)
(defun ccls/references-not-call ()
  (interactive)
  (lsp-ui-peek-find-custom "textDocument/references"
                           (plist-put (lsp--text-document-position-params) :excludeRole 32)))

(provide 'init-cpp)
