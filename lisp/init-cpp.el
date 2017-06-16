;; config for C++ and CUDA

(require-package 'cuda-mode)
(add-to-list 'auto-mode-alist '("\\.cu\\'" . cuda-mode))

(provide 'init-cpp)
