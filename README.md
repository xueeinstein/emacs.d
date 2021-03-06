Emacs.d
==========================

#### Table of Contents

   * [Emacs.d - ShadowThink](#emacsd---shadowthink)
      * [Introduction](#introduction)
      * [Requirements](#requirements)
      * [Installation](#installation)
      * [Documentation](#documentation)
         * [Evil Group Basics](#evil-group-basics)
            * [Cursor movement](#cursor-movement)
            * [Code folding](#code-folding)
            * [Window splitting and switching](#window-splitting-and-switching)
            * [Code comment and uncomment](#code-comment-and-uncomment)
         * [Projects](#projects)
            * [Git tools](#git-tools)
            * [Find files](#find-files)
            * [Search in files](#search-in-files)
         * [Elpy Basics](#elpy-basics)
            * [Interactive Python](#interactive-python)
            * [Documentation](#documentation-1)
            * [Testing](#testing)
            * [Refactoring](#refactoring)
         * [ESS Basics](#ess-basics)
            * [Interactive R](#interactive-r)
            * [Documentation](#documentation-2)
            * [Debug](#debug)

## Introduction

This Emacs configuration is forked from [Steve Purcell](https://github.com/purcell/emacs.d). Currently, [emacs.d](https://github.com/xueeinstein/emacs.d) is maintained by [Bill Xue](https://shadowthink.com), becoming more friendly for previous Vim users.

Emacs itself comes with support for many programming languages. This config adds improved defaults and extended support for the following:

* Ruby / Ruby on Rails
* CSS / LESS / SASS / SCSS
* HTML / Markdown / Textile / ERB
* Clojure (with Cider and nRepl)
* Javascript / Coffeescript
* Python (with [Elpy](https://github.com/jorgenschaefer/elpy))
* R (with [ESS](https://ess.r-project.org/))
* Haskell
* Erlang
* Common Lisp (with [Slime](https://common-lisp.net/project/slime/))

In particular, there's a nice config for tab autocompletion, and *flycheck* is used to immediately highlight syntax errors in Ruby, HAML, Python, Javascript, PHP and a number of other languages.

## Requirements

To support all features of numbers of key packages, Emacs 24 and above is required. Other programs are also required by third part packages. Please set up the required package before installation.

* `elpy`: rope/jedi, flake8, importmagic, autopep8, ipython.
* `helm`: ack-grep.

## Installation

To install, clone this repo to `~/.emacs.d`, i.e. ensure that the init.el contained in this repo ends up at `~/.emacs.d/init.el`:

```shell
git clone https://github.com/xueeinstein/emacs.d.git ~/.emacs.d
```

Upon starting up Emacs for the first time, further third-party packages will be automatically downloaded and installed. If you encounter any errors at that stage, try restarting Emacs, and possibly running `M-x package-refresh-contents` before doing so.

## Documentation

### Evil Group Basics

Evil is an extensible vi layer for Emacs. In this configuration, to make it more like my [Vim configuration](https://github.com/xueeinstein/dotfiles/blob/master/.vimrc), I setup supplementary package like `evil-leader`, `evil-nerd-commenter`, `hideshow`, `neotree`, `fic-mode` and `avy`. Here, I call them __Evil group__.

#### Cursor movement

Inherit basic Vim cursor movement rules. For easy cursor motion, I configure Emacs with `avy` to support the cursor motion like `vim-easymotion`.

* `<leader> f` mark forward words at vim normal mode, and type marks to jump to the target word.
* `<leader> a` mark backword words at vim normal mode, and type marks to jump to the target word.
* `M-;` mark all words, and type marks to jump to the target word.
* `M-l` mark lines, and type marks to jump to the target line.

#### Code folding

Coding folding is another important feature of Vim. Similarly as my [Vim configuration](https://github.com/xueeinstein/dotfiles/blob/master/.vimrc), I use `zf` to fold code, and `zo` to unfold code with the help of `hideshow`. Moreover, `hideshow` has more powerful code folding functions like hiding or showing all blocks. Summary:

* `zm` hide all blocks at vim normal mode.
* `zr` show all folding blocks at vim normal mode.
* `zf` hide current block at vim normal mode.
* `zo` show current folding block at vim normal mode.

#### Window splitting and switching

Originally, in Emacs, we split window vertically by typing `C-x 3`, and split window horizontally by typing `C-x 2`. After window spliting, Emacs will automatically guide you to the new window which is initialized with a new available buffer. However, sometimes, you want to spliting window and replicate the original buffer such that you can scroll and enlarge the veiw of the current buffer. Here, `<leader> h` and `<leader> v` can satisfy your requirements.

* `<leader> h` split window horizontally.
* `<leader> v` split window vertically.
* `C-<left>` switch to left window.
* `C-<right>` switch to right window.
* `C-<up>` switch to top window.
* `C-<down>` switch to bottom window.
* `M-<left>` move current window to left
* `M-<right>` move current window to right

#### Code comment and uncomment

* `<leader> ci` comment/uncomment lines.
* `<leader> cl` comment/uncomment from current line to the user-specified line. You can input the rightest digit(s) to specify the line number if you want to type less. For example, say current line number is 497. `C-u 3 <leader> cl` will comment to the line 503 because the rightest digit of “503” is 3.
* `<leader> cc` Copy and paste lines, then comment out original lines. You can also input the rightest digit(s) to specify the line number as `<leader> cl`.
* `<leader> cp` comment/uncomment paragraphs which separated by empty lines.

### Projects

#### Git tools

In this Emacs config, it has several git tools like `magit` and `vc`. It's recommended to use `C-x g` to trigger `M-x magit-status`. Next type `h` for help. Then you can follow the instruction to do kinds of git operations.

#### Find files

This function is powered by `find-file-in-project`. For a given project with version control like git, `find-file-in-project` will automatically set rot git root directory as the project root directory. Then you can use `C-c C-f` to trigger `M-x ffip` and quickly find project files.

#### Search in files

To search string in files under current folder, you can use `helm` with `ack-grep`. Use `C-x-f` and navigate to your expected directory, within the `helm-find-files` session, invoke `ack-grep` with `C-s` to search a file/directory on highlighted entry in the Helm buffer.

### Elpy Basics

#### Interactive Python

* `M-x elpy-python2` select to use Python2 configuration.
* `M-x elpy-python3` select to use Python3 configuration.
* `C-c C-z`, `M-x elpy-shell-switch-to-shell` switch to buffer with a Python interpreter running, starting one if necessary.
* `C-c C-j`, `M-x elpy-shell-send-current-statement` send current statement to Python shell.
* `C-c C-c`, `M-x elpy-shell-send-region-or-buffer` whenever you are in an Elpy buffer, C-c C-c will send Python code to the subprocess. If there is an active region, that region will be sent; if not, the whole buffer is sent.

#### Documentation

`C-c C-d`, `M-x elpy-doc` When point is on a symbol, Elpy will try and find the documentation for that object, and display that. If it can’t find the documentation for whatever reason, it will try and look up the symbol at point in pydoc. If it’s not there, either, it will prompt the user for a string to look up in pydoc.

#### Testing

* `C-c C-t`, `M-x elpy-test` start a test run.
* `M-x elpy-set-test-runner` change the current test runner.

#### Refactoring

* `C-c C-r r`, `M-x elpy-refactor` run the Elpy refactoring interface for Python code based on `rope`.
* `C-c C-r f`, `M-x elpy-format-code` format code using the available formatter.

### ESS Basics

#### Interactive R

* `M-x R` start a R inferior process.
* `C-c C-z` switch between R inferior buffer and script buffer.
* `C-c C-l`, `M-x ess-load-file` prompt for a script to load into the ESS process using `source()`.
* `C-c C-j` eval current statement in R inferior.
* `C-c C-r` eval current region in R inferior.
* `C-c C-q` stop R inferior process.

#### Documentation

Use `C-c C-v` to pop up a help buffer for an R object or function.

#### Debug

It's recommended to use `C-c C-t ?` to see the help information for ESS tracebug. A short tutorial is at [https://code.google.com/archive/p/ess-tracebug/wikis/GettingStarted.wiki](https://code.google.com/archive/p/ess-tracebug/wikis/GettingStarted.wiki).
