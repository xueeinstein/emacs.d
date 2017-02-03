Emacs.d - ShadowThink
==========================

#### Table of Contents

   * [Emacs.d - ShadowThink](#emacsd---shadowthink)
      * [Introduction](#introduction)
      * [Requirements](#requirements)
      * [Installation](#installation)

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

* `elpy`: rope/jedi, flake8, importmagic, autopep8, ipython

## Installation

To install, clone this repo to `~/.emacs.d`, i.e. ensure that the init.el contained in this repo ends up at `~/.emacs.d/init.el`:

```shell
git clone https://github.com/xueeinstein/emacs.d.git ~/.emacs.d
```

Upon starting up Emacs for the first time, further third-party packages will be automatically downloaded and installed. If you encounter any errors at that stage, try restarting Emacs, and possibly running `M-x package-refresh-contents` before doing so.
