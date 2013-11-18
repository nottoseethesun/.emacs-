;; This is a web programmer's .emacs file for GNU Emacs on Mac OS X 7+ and Ubuntu 12.04 LTS.
;;
;; Requires Emacs version 24.3.x or better.
;;
;; This file has been tested on:
;;
;;     * GNU Emacs on Ubuntu 12.04 LTS (using Emacs v24 from the cassou/emacs launchpad-hosted ppa.  See:
;;            http://ubuntuhandbook.org/index.php/2013/09/install-upgrade-to-emacs-24-3-in-ubuntu-13-04-12-10-12-04/
;;            M-x version yields:
;;                GNU Emacs 24.3.1 (x86_64-pc-linux-gnu, GTK+ Version 3.4.2) of 2013-10-03 on lakoocha, modified by Debian
;;     * A plain build of GNU Emacs on OS X, available at http://emacsformacosx.com/ .  M-x version yields:
;;         GNU Emacs 24.3.1 (x86_64-apple-darwin, NS apple-appkit-1038.36) of 2013-03-12 on bob.porkrind.org
;;
;; First-time users:
;;     * This file uses '/opt/local/share/emacs/site-lisp', which doesn't exist on some systems.
;;       If yours doesn't have that file path, you can change that file path or create it.
;;     * Before installing this dot-emacs file (or after, if you don't mind getting an error message), you will need to run 'M-x package-list' from your Emacs.
;;     * This file requires two Emacs optional add-on files that aren't supported by Emacs packaging services used here.
;;       They are html5-el and desktop-menu .  If you want them, you will need to manually install them.
;;       If not, you will need to comment out or delete the references to them from this file.
;;
;; Windows users: This file contains commented-out segments that would be of use for running this file on Windows.
;;
;; The GNU Emacs Homepage is located at:
;;
;;             http://www.gnu.org/directory/GNU/emacs.html
;;
;; This Document Last Modified: 2013-11-17.
;;
;; Portability: Comment out code for one platform and comment in the code for another.  For example, this file is currently set for Unix.
;;
;; @author: Christopher M. Balz.
;;
;; Hacks: Any hacks or workarounds are marked with '@workaround' (no quotes).  You can find them by searching on that character string.
;;
;; Known issues: Some package used here is, at the time of this writing, causing the start-up warning message, "package assoc is obsolete!".
;;               This is harmless, and will likely be fixed soon, as Emacs 24 obsoleted that package.  If not, a process of elimination can find the culprit package.
;;
;; Aquamacs Users:
;;   This file will not work with Aquamacs, as this file requires solid support for the Emacs packaging systems (such as ELPA and Marmalade).
;;   Find a .emacs file for the Emacs 23 build of Aquamacs on github at: https://github.com/christopherbalz/.emacs-/blob/master/aquamacs/.emacs
;;   Find its companion file (see above for details), 'customizations.el', at:
;;
;;       https://github.com/christopherbalz/.emacs-/blob/master/aquamacs/customizations.el
;;
;;   Note that for Aquamacs, custom extensions and packages mananged by package repositories (such as elpa) are often located under:
;;       '~/Library/Application Support/Aquamacs Emacs/' and '/Library/Application Support/Aquamacs Emacs/'
;;
;;
;; General Notes:  It is often said that a new Emacs user should stay away from old, crusty
;;                 '.emacs' files from others.  However, the only way that I ever was able
;;                 to get a reasonable return on the investment of my time put into setting
;;                 up my Emacs configurations was by borrowing code snippets from others.
;;                 It is true that no '.emacs' file should be used uncritically, by newbie or
;;                 by others.
;;
;;                 However, for the best user base, new users should be able to
;;                 fairly easily clip out sections of '.emacs' files that interest them and put
;;                 them to use right away in their own '.emacs' files.  To this end, I have
;;                 attempted to effectively segment the various independent components of this
;;                 '.emacs' file and have documented what I have done as clearly as possible.
;;                 It's very exciting how Emacs modes related to software engineering for the
;;                 web are maturing.
;;

;; ------------   Invocation of Gnu Emacs on Windows:
;;
;;
;;    First, set user-specific 'HOME' environment variable to 'C:/cygwin/home/Christopher Balz/'
;;    (substituting whatever your home directory is), which is
;;    the directory in which your '.emacs' file is located.  Do this by going to the 'Control Panel',
;;    then to 'System', then to 'Advanced', then to 'Environment Variables', the to 'Variables
;;    for <user>'.
;;
;;    Next, run the 'addpm.exe' program to install Emacs on Windows.  You don't have to do this,
;;    and can do the necessary tasks to run Emacs on Windows manually, but this is the best way to go.
;;
;;    If you experience temporary "blanking out" of the screen when you select one of the two Emacs windows
;;    (meaning specifically the Windows command line), select 'Properties' on the Emacs short cut,
;;    select the 'Options' tab, select the 'Window' radio button, and then select 'Ok' and 'Save
;;    for future sessions.'  If you run Windows command programs from Emacs, such as Cygwin, you
;;    may also get "blanking out" of the screen unless you run "Command" from the Windows "Run" option
;;    on the "Start" menu, right-click on the window title bar, select 'Default',
;;    and perform the same property change just described, selecting "Window" instead of "Full Screen".
;;

;; ------------  Commense lisping:

;; Emacs Debug Start-Up Mode: Provide a useful error trace if loading this .emacs fails.  Turn this on if there are error messages in the *Messages* buffer:
(setq debug-on-error t)

;; Begin: Turn off unnecessary gui elements: - - - -
;; Note that on Aquamacs, per http://www.emacswiki.org/emacs/AquamacsFAQ , it's a setting in the Aquamacs 'customizations.el' (mentioned above).
;;    E.g.:  “Options → Appearance → Adopt Face and Frame Parameters as Frame Default”. Then choose “Options → Save Options”.
(if (not(eq (boundp 'tabbar) nil))
    (tabbar-mode -1)          ;; hide the tab bar that just recently became turned on by default in some flavors of Emacs, around Emacs v23.
)
;; End: Turn off unnecessary gui elements. - - - -

;; List Emacs command-line arguments:
(message "--------------")
(message "Listing the remaining command-line arguments given to Emacs:")
(dolist (arg command-line-args)(
                                message arg)
        )
(message "--------------")

;; Manage possibility of running under a bare terminal with no windowing (no X Windows, etc):
(if (not(eq window-system nil))
    (message "Running under a windowing system.")
  (message "Not running under a windowing system: Skipping any code that requires a windowing system.")
  )

;; If you have an oversensitive mouse wheel, stay out of trouble by disabling mouse-wheel pasting:
;; (defun mouse-yank-at-click (event)
;; )


;; Begin: Set character/file encoding - - - -

;; (set-buffer-file-coding-system 'iso-latin-1-unix t)
;; Use the utf8-unix file format always:
(set-buffer-file-coding-system 'utf-8-unix t) ;; Unicode.
;; Use utf-8 everywhere else:
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; End: Set character/file encoding - - - -


;; Start a Unicode-based shell: This is key for handling shell processes that output utf-8 characters.
;; Some error messages will tell you they failed with a utf-8 char, in which case it's helpful to be able to see it.
(defun u-shell ()
  "Create Shell that supports UTF-8."
  (interactive)
  (set-default-coding-systems 'utf-8)
  (shell))

;; Begin Load Path Setting - - - -

;; Add the site directory (the site directory is used to contain non-core Emacs Lisp packages)
;; to the Emacs load-path.  The Emacs load-path is the list of directories where Emacs searches for packages that you require.
;; This must be at the head of your .emacs file.  This code prepends the site directory to the load path:

;; Standard emacs lisp access (for non-byte-compiled access):

;; - - - Begin Windows paths:
;;(add-to-list 'load-path (expand-file-name "C:/Progra~1/emacs/emacs-21.3/site-lisp/"))
;;(add-to-list 'load-path (expand-file-name "C:/Progra~1/emacs/emacs-21.3/site/lisp/progmodes/"))
;; System-wide emacs customizations:
;; (add-to-list 'load-path (expand-file-name "C:/Progra~1/emacs/site/"))
;; (add-to-list 'load-path (expand-file-name "C:/Progra~1/emacs/site/snippets/"))
;; (add-to-list 'load-path (expand-file-name "/cygdrive/c/Program Files/emacs/site/"))
;; - - - End Windows paths.

;; For Mac: MacPorts-installed Emacs packages and other custom-added packages go in '/opt/local/share/emacs'.
;; Note that this will augment the `load-path` that Aquamacs uses (to see them, if you are on Aquamancs, check your load-path variable via C-h v load-path).
(add-to-list 'load-path "/opt/local/share/emacs/site-lisp/")

;; Personal emacs/site:
(setq load-path (cons (expand-file-name "~/emacs/site/") load-path)) ;; Prepends in order to override analogous system libs.

;; So that Emacs can find the home directory files (desktop, etc.):
(add-to-list 'load-path (expand-file-name "~/.emacs"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.desktops"))

;; Specific Packages:
(add-to-list 'load-path "/opt/local/share/emacs/site-lisp/html5/html5-el-master") ;; From: https://github.com/hober/html5-el/tree/master

;; - - - - End Load Path Setting

;;  - - - Begin CEDET
;; Load a more up-to-date CEDET than the one that ships with emacs.
;; See cedet/common/cedet.info for configuration details.
;; IMPORTANT: Tou must place this *before* any CEDET component (including
;; EIEIO) gets activated by another package (Gnus, auth-source, ...).
;; (load-file "/home/user/cedet/cedet-devel-load.el")

;; Add further minor-modes to be enabled by semantic-mode.
;; See doc-string of `semantic-default-submodes' for other things
;; you can use here.
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
;; (add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)

;; Enable Semantic
;; (semantic-mode 1)

;; Enable EDE (Project Management) features
;;(global-ede-mode 1)
;;  - - - End CEDET


;; - - - Begin: Package Management System: Marmalade: http://marmalade-repo.org/ - - - -

(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
              '("elpa" . "http://tromey.com/elpa/"))
(package-initialize)

(defvar my-packages '(
                      ;;  - - - Tools
              exec-path-from-shell
              auto-complete
              ecb
              eimp
              w3
              flymake
              flymake-less
              flymake-sass
              flymake-css
              flymake-shell
              flymake-json
              flymake-jshint
              flymake-csslint
              elein
              ;; - - - JavaScript
              js2-mode
              json-mode
              ;; - - - AppleScript
              applescript-mode
              ;; - - - Other Languages
              php-mode
              ;; - - - Markup
              web-mode
              multi-web-mode
              less-css-mode
              sass-mode
              css-mode
              markdown-mode
              mustache-mode
              handlebars-mode
              ;; - - - Revision Control
              magit
              ;; - - - Clojure packages:
              clojure-mode
              clojure-test-mode
              cljsbuild-mode
              clojurescript-mode
              clojure-project-mode
              cider
              nrepl
              ac-nrepl
              ;; - - - Config File Types
              apache-mode
              crontab-mode
              csv-mode
              cmake-mode
              ;; - - - Communication
              circe
              jabber
              ;; - - - Games
              chess
              ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; - - - End: Package Management System: Marmalade - - - -


;; - - - - For non-Aquamacs ports to Mac OS X, must import the shell env, and also, do the @workaround just below:
;; https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns)) ;; If running on Aquamacs, this may need to be altered or removed.
  ;; - - - Begin @workaround for issue described at: http://lists.gnu.org/archive/html/bug-gnu-emacs/2012-07/msg00911.html
  (setq ls-lisp-use-insert-directory-program t)
  (setq insert-directory-program "gls")
   ;; - - - End workaround.
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "CLOJURESCRIPT_HOME")
  (exec-path-from-shell-copy-env "HOME_BIN")
  (exec-path-from-shell-copy-env "JAVA_HOME")
  (exec-path-from-shell-copy-env "ANT_OPTS")
  (exec-path-from-shell-copy-env "GREP_OPTIONS")
  (exec-path-from-shell-copy-env "EDITOR")
  (exec-path-from-shell-copy-env "PS1")
  (exec-path-from-shell-copy-env "CLICOLORS")
  (exec-path-from-shell-copy-env "LSCOLORS")
)

;; - - - Begin Auto-Complete (as distinguished from `autocomplete`)
;;     This is non-CEDET autocompletion and it knows about JavaScript.
;;     Manual: http://cx4a.org/software/auto-complete/manual.html
(add-to-list 'load-path "/opt/local/share/emacs/site-lisp/auto-complete/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;; - - - End Auto-Complete

(global-set-key [(control tab)] 'dabbrev-expand) ;; Standard Emacs identifier completion (autocomplete/autocompletion).

;; desktop-menu mode - useful for keeping two instances of Emacs on their own desktop. From: http://www.emacswiki.org/emacs/desktop-menu.el
(autoload 'desktop-menu "desktop-menu" "desktop-menu mode, useful if you have more than one instance of Emacs under your username." t)

;; - - - - Begin Image Section

;; For viewing images:
(if (not(eq window-system nil))
    (autoload 'thumbs "thumbs" "Preview images in a directory." t)
)

;; Eimp Minor Mode
;;
;; This package allows interactive image manipulation from within
;; Emacs.  It uses the mogrify utility from ImageMagick to do the
;; actual transformations.
;;
;; Switch the minor mode on programmatically with:
;;
;;    (eimp-mode 1)
;;
;; or toggle interactively with M-x eimp-mode RET.
;;
;; Switch the minor mode on for all image-mode buffers with:
;;
(autoload 'eimp-mode "eimp" "Emacs Image Manipulation Package." t)
(add-hook 'image-mode-hook 'eimp-mode)

;; - - - - End Image Section

;; - - - Begin woman set-up, to be able to do 'esc-x woman' to view man pages.
(if (getenv "MANPATH")
  ;; Then do nothing: woman will just use the system manpath (works on Mac OS X with MacPorts, etc).

  ;; Else, use a rhel set-up.  This code path here of course will not run the fail-overs built into woman
  ;; (which don't work on rhel), as described here: http://www.gnu.org/software/emacs/manual/html_node/woman/Topic.html

  ;;     On many Linux systems, such as rhel, the MANPATH environment variable is not set.  Instead, 'man' uses a script,
  ;;     such as rhel's '/etc/man.config', that woman doesn't understand.  So in that case we
  ;;     do this manual configuration.  The values below are pasted from there.
  (setq woman-manpath '("/usr/man"
                        "/usr/share/man"
                        "/usr/local/man"
                        "/usr/local/share/man"
                        "/usr/X11R6/man"
                        "/opt/*/man"
                        "/usr/lib/*/man"
                        "/usr/share/*/man"
                        "/usr/kerberos/man")))

(autoload 'woman "woman" "Browse man pages." t)
;; - - - End woman set-up

;; - - - Begin Java Development Environment for Emacs (JDEE)
;;(add-to-list 'load-path (expand-file-name "~/emacs/site/jde/lisp"))

;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
;;(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;;(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;;(semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberent ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)
;;   Or, use one of these two types of support.
;;   Add support for new languges only via ctags.
;; (semantic-load-enable-primary-exuberent-ctags-support)
;;   Add support for using ctags as a backup parser.
;; (semantic-load-enable-secondary-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)

(setq shell-file-name "bash")                     ;; Leave this line regardless of host o/s (Unix, Win, etc).
(setenv "SHELL" shell-file-name)                  ;; Leave this line regardless of host o/s (Unix, Win, etc).

;; - - - Begin Cygwin
;; For use of Bash shell via Cygwin on Windows, available from:
;;           http://www.cygwin.com/
;; (if you do not have Cygwin installed, comment all of this section out).
  ;; This assumes that Cygwin is installed in C:\cygwin (the
  ;; default) and that C:\cygwin\bin is not already in your
  ;; Windows Path (it generally should not be).
      ;;
;;(setq exec-path
;;       (append (list
;;                "c:/cygwin/bin"
;;                "c:/Progra~1/emacs/site/w3m-0.5.1"
;;                )
;;               exec-path))
;; (setenv "PATH" (concat "c:\\cygwin\\bin;c:\\Progra~1\\emacs\\site\\w3m-0.5.1;" (getenv "PATH")))
;;
;;; Add Cygwin Info pages
;;(setq Info-default-directory-list (append Info-default-directory-list (list "c:/cygwin/usr/info/")))
;; (setq explicit-bash-args '("--login" "--init-file" "c:/home/cbalz/.bash_profile" "-i"))  ;; For Cygwin (on Windows) Only.  Change to your user-name.
;; - - - End Cygwin

(setq explicit-shell-file-name shell-file-name)   ;; Leave this line regardless of host o/s (Unix, Win, etc).

;; Use ANSI colors within shell-mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; End of bash shell use section.

;; This removes unsightly ^M characters that would otherwise appear in the output of code saved in DOS format.
(add-hook 'comint-output-filter-functions
          'comint-strip-ctrl-m)

;; Set start-up directory with Unix nomenclature
;; (your configuration files _must_ be in this directory):
(setq startup-directory "~/")

;; Put autosave files (ie #foo#) in one place, *not*
;; scattered all over the file system!  '#' files will crash a variety of directory-reading programs.
;; Courtesy: http://cheat.errtheblog.com/s/emacs_tips/
;;
(defvar autosave-dir
 ;; Use this by default: (concat "/tmp/emacs_autosaves/" (user-login-name) "/"))
 ;; Use this if the contents of '/tmp' can get deleted:
 (concat "~/tmp/emacs_autosaves/" (user-login-name) "/"))
(make-directory autosave-dir t)
(setq auto-save-file-name-transforms `(("\\(?:[^/]*/\\)*\\(.*\\)" ,(concat
                                                                                                                                        autosave-dir "\\1") t)))

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir (concat "~/tmp/emacs_backups/" (user-login-name) "/"))
(setq backup-directory-alist (list (cons "." backup-dir)))

(autoload 'php-mode "php-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;; - - - Begin ClojureScript
(defun cljs-repl ()
    (interactive)
    (setq inferior-lisp-program "browser-repl")
    (run-lisp))
;; - - - End ClojureScript

;; - - - Begin JavaScript Section

(autoload 'js2-mode "js2-mode" nil t) ;; http://code.google.com/p/js2-mode/

;; - - - Set js2-mode to know about globals: http://www.emacswiki.org/emacs/Js2Mode
;; After js2 has parsed a js file, we look for jslint globals decl comment ("/* global Fred, _, Harry */") and
;; add any symbols to a buffer-local var of acceptable global vars
;; Note that we also support the "symbol: true" way of specifying names via a hack (remove any ":true"
;; to make it look like a plain decl, and any ':false' are left behind so they'll effectively be ignored as
;; you can;t have a symbol called "someName:false"
(add-hook 'js2-post-parse-callbacks
          (lambda ()
            (when (> (buffer-size) 0)
              (let ((btext (replace-regexp-in-string
                            ": *true" " "
                            (replace-regexp-in-string "[\n\t ]+" " " (buffer-substring-no-properties 1 (buffer-size)) t t))))
                (mapc (apply-partially 'add-to-list 'js2-additional-externs)
                      (split-string
                       (if (string-match "/\\* *global *\\(.*?\\) *\\*/" btext) (match-string-no-properties 1 btext) "")
                       " *, *" t))
                ))))

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)) ;; '.json' files do not work well at the time of this writing with 'js2' mode (JavaScript-IDE).
(autoload 'json-mode "json-mode" nil t) ;; https://github.com/joshwnj/json-mode
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

;; An optional Javascript mode for shellserver to Mozilla
;; See https://sekhmet.acceleration.net/ADW/JsShellServer
;;(add-hook 'javascript-mode-hook 'js-mode)
;;(autoload 'js-mode "js-mode" nil t)

;; This is the container for my custom js editing mode
(defun my-js-indent-setup ()
 (setq c-default-style "bsd") ;; bsd stroustroup
 ;; (setq indent-tabs-mode t)        ;; turn on tabs for js
 (setq indent-tabs-mode nil)   ;; turn off tabs for js
 (setq c-basic-offset 4)
 (lambda () (js-mode))
 (js-mode))

;; Add the above hook to the c-mode.
;;(add-hook 'javascript-mode-hook 'my-js-indent-setup)
(add-hook 'js2-mode-hook 'my-js-indent-setup)

;; - - - End JavaScript Section


;; ----- Begin Handlebars/Mustache Template Editing Section: From https://github.com/mustache/emacs/blob/master/mustache-mode.el
;;     @to-do: Come up with a way in Emacs to match '.html' that's not '.mu.html'.
(require 'mustache-mode)
(setq auto-mode-alist
      (cons '("\\.\\(dust\\|hbs\\)" . mustache-mode)
            auto-mode-alist))
;; ----- End Handlebars/Mustache Template Editing Section


;; ----- Begin XML--XSL--HTML Editing Section
;;   - - - From http://web-mode.org/
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
;; Necessary to override the application of html-mode:
(add-to-list 'magic-mode-alist '("<!DOCTYPE html>" . web-mode) )
(add-to-list 'magic-mode-alist '("<!doctype html>" . web-mode) )
(add-to-list 'magic-mode-alist '("<html>" . web-mode) )

(setq auto-mode-alist
      (cons '("\\.\\(fo\\|xml\\|xsl\\|xsd\\|rng\\|xhtml\\)\\'" . nxml-mode)
              auto-mode-alist))


;; The following first-line matches are used to load nxml-mode over html-helper mode, since we use the non-xml html5 package (which does also do xhtml5).

 (defun my-nxml-indent-setup ()
   (setq indent-tabs-mode nil) )
 ;; Add the above hook to the nxml-mode.
 (add-hook 'nxml-mode-hook 'my-nxml-indent-setup)

;;   - - - Begin html5 section (also added to load path in custom directory, above).
(eval-after-load "rng-loc"
  '(add-to-list 'rng-schema-locating-files "/opt/local/share/emacs/site-lisp/html5/html5-el-master/schemas.xml"))

(require 'whattf-dt)
;;   - - - End html5 section (also added to load path in custom directory, above).
;;
;; ----- End XML--XSL--HTML Editing Section


;; ;; --------- Begin CSP Section: For CSP, a formal notation for _c_ommunicating _s_equential _p_rocesss
;; (add-to-list 'load-path (expand-file-name "c:/Progra~1/emacs/site/csp-mode-1.0.1/"))
;; (require 'csp-mode)
;; (setq auto-mode-alist (cons '("\\.csp$" . csp-mode) auto-mode-alist))
;; (setq csp-validate-command "c:/Windows/System32/cmd.exe e:off /c 'C:\\Progra~1\\probe-1.30-windows\\probe-1.30-windows\\probe.exe'" )
;; ;; --------- End CSP Section

;; ;; -------- Begin Promela Section, a concurrent process specification language (used to prevent lost spaceships and such):
;; (autoload 'promela-mode "promela.el" "PROMELA mode" nil t)
;; (setq auto-mode-alist
;;       (append
;;        (list (cons "\\.promela$"  'promela-mode)
;;                   (cons "\\.spin$"     'promela-mode)
;;                   (cons "\\.pml$"      'promela-mode)
;;                   ;; (cons "\\.other-extensions$"     'promela-mode)
;;              )
;;        auto-mode-alist))
;; ;; --------  End Promela Section


;; - - - Begin Markdown Mode
;; From http://jblevins.org/projects/markdown-mode/ :
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;; - - - End Markdown Mode

;; ----- Begin Sass Css Mode
;; (require 'sass-mode)
;; ----- End Sass Mode
;; ----- Begin Sass scss flavor Mode
;; (require 'scss-mode)
;; ----- End Sass scss flavor Mode

;; ----- Begin Less Css Mode
(require 'flymake-less)
(add-hook 'less-css-mode-hook 'flymake-less-load)
;; ----- End Less Css Mode

;; Revision Control
(require 'magit) ;; Git integration: works with the built-in vc-git.

;; Make sure that .emacs file is edited in lisp mode:
(setq auto-mode-alist (cons '("\.emacs" . lisp-mode)        auto-mode-alist))

;; - - - Begin Diary and Appointment Notification Section.
;; There are also some variables set via the Emacs Customization Utility.
;; See the end of the file for those.
;; Read the diary:
(diary)
(diary 0)
;; - - - End Diary and Appointment Notification Section.

;; - - - Begin Calendar: Fancy display for Calendar
;; Here is some code to make your calendar and diary display fancier:
 (setq view-diary-entries-initially t
       mark-diary-entries-in-calendar t
       number-of-diary-entries 7)
 (add-hook 'diary-display-hook 'fancy-diary-display)
 (add-hook 'today-visible-calendar-hook 'calendar-mark-today)

;; Special function to make appointments work:
(defun update-my-calendar ()
  (let ((diary-buffer (get-file-buffer diary-file))
        (number-of-diary-entries 30))
    (if diary-buffer
        (progn
          (set-buffer diary-buffer)
          (revert-buffer t t)))
    (calendar)))
;; - - - End Calendar and Appointment Notification Section.

;; - - - Begin mode-line customization:
;; Show column number on mode line.
(column-number-mode t)
;; Show time on mode line, and set appointment notification.
;; (day-and-date)
(display-time)
;; Show the directory of a file or shell buffer in the mode-line ( http://www.emacswiki.org/emacs/ModeLineDirtrack ):
(defun add-mode-line-dirtrack ()
  (add-to-list 'mode-line-buffer-identification
               '(:propertize (" " default-directory " "))))
(add-hook 'shell-mode-hook 'add-mode-line-dirtrack)
(add-hook 'find-file-hook 'add-mode-line-dirtrack)
;; - - - End mode-line customization.

;; - - - General Useful Emacs Switches and Functions Section - - - -

;; Global key maps:
(global-set-key "\C-c\C-v" 'browse-url-of-buffer)
(global-set-key "\C-xU" 'browse-url)
(global-set-key "\C-xP" 'browse-url-at-point)
(global-set-key "\e`" 'search-forward-regexp)
(global-set-key "\e/" 'replace-regexp)
(global-set-key "\C-xtl" 'goto-line)
(global-set-key "\e[" 'enlarge-window)
(global-set-key "\e]" 'shrink-window)
(global-set-key "\e=" 'eval-current-buffer)
(global-set-key "\eg" 'magit-status)

;; Here's some code which is quite handy eg. after doing an update from revision control (i.e., cvs or svn),
;; which results in lots of files being updated. The following function reverts all Emacs file buffers.
;; ( From http://kavaro.com/mediawiki/index.php/Emacs-hacks ).
(defun revert-all-buffers ()
  (interactive)
  (let ((current-buffer (buffer-name)))
    (loop for buf in (buffer-list)
          do
          (unless (null (buffer-file-name buf))
            (switch-to-buffer (buffer-name buf))
            (revert-buffer nil t)))
    (switch-to-buffer current-buffer)
    (message "All buffers reverted!")))


;; These two key bindings are for up and down scrolling by a either single line at a time
;; or by N lines at a time (default is scroll by one single line at a time).  This is
;; very useful when working with narrow horizontal windows.  ;~)
;; To enter the desired N, hold down \C and type the number and then hit z or q, all the
;; while holding down \C.
;; From the "Writing GNU Emacs Extensions" book, by Bob Glickstein.
(defun scroll-n-lines-up (&optional n)
  "Scroll up N lines (1 line by default)."
  (interactive "P")
  (scroll-up (prefix-numeric-value n)))

(defun scroll-n-lines-down (&optional n)
  "Scroll down N lines (1 line by default)."
  (interactive "P")
  (scroll-down (prefix-numeric-value n)))

(global-set-key "\C-q" 'scroll-n-lines-up)
(global-set-key "\C-z" 'scroll-n-lines-down)


;; These two bindings make it easier to find a mismatched parenthesis:
(global-set-key "\e'" 'forward-sexp)
(global-set-key "\e;" 'backward-sexp)

;;; Bracket/brace/parentheses highlighting:
   ;; The following is the command for Emacs 20.1 and later:
(show-paren-mode 1)

;; Makes the C-x% keybinding show the matching parenthesis (smooth, curly, or square braket).
;;    - http://www.emacswiki.org/emacs/ParenthesisMatching
(global-set-key "\C-x%" 'goto-match-paren)
(defun goto-match-paren (arg)
  "Go to the matching parentheses if on (), {}, or [] "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))

;; Windows only: The following functions enable on-the-fly switching between the bash shell and DOS:

;; (defun set-shell-bash()
;;   (interactive)
;;   ;; (setq binary-process-input t)
;;   (setq shell-file-name "bash")
;;   (setq shell-command-switch "-c")
;;   (setq explicit-shell-file-name "bash")
;;   (setenv "SHELL" explicit-shell-file-name)
;;   (setq explicit-sh-args '("--login" "--init-file" "c:/home/cbalz/.bash_profile" "-i"))
;;   (setq w32-quote-process-args ?\")
;;   (setq mswindows-quote-process-args t)
;;   )

;; (defun set-shell-cmdproxy()
;;   (interactive)
;;   (setq shell-file-name "cmdproxy")
;;   (setq explicit-shell-file-name "cmdproxy")
;;   (setenv "SHELL" explicit-shell-file-name)
;;   (setq explicit-sh-args nil)
;;   (setq w32-quote-process-args nil)
;;   )

;; (global-set-key "\C-xg" 'set-shell-bash) ;; g for Gnu (\C-xb is used for buffer switch command).
;; (global-set-key "\C-xd" 'set-shell-cmdproxy)
;; End shell-switch on-the-fly.


;; Begin move-to-window block:
;; This code is from the O'Reilly "GNU Emacs Extensions" book.
;; The purpose of it is to make a reasonable way to move to the next OR previous window.
;; Change from C-x o to C-x n, so that we have Next and Previous.
(global-set-key "\C-xn" 'other-window)

;; We must make our own function to go to the previous window (but it's simple):
(defun other-window-backward ()
  "Select the previous window."
  (interactive)
  (other-window -1))
;; Now we can bind to this function:
(global-set-key "\C-xp" 'other-window-backward)
;; End move to window block.

;; This turns on the buffer select list in the minibuffer to make it easy to
;; edit any buffer in a given window or frame (C-r and C-s move backwards and forwards, respectively,
;; through the buffer select list).
;;   - - - - Begin for old Emacs ( < Emacs 24.6 )
;; (require 'iswitchb)
;; (iswitchb-default-keybindings) ;; not available on emacs 24.6:
;;   - - - - End for old Emacs ( < Emacs 24.6 )
(iswitchb-mode 1)

;; Set a high recursion limit for parsing the long java files:
(setq max-specpdl-size 1000)

(put 'upcase-region 'disabled nil)

(put 'downcase-region 'disabled nil)

;; Adjust the colors and fonts to preference:
(set-default-font "-adobe-courier-*-*-*-*-12-*-*-*-*-*-*-*") ;; Unix, if that font is present.
;; (set-default-font "Fixedsys") ;; Windows.
(set-face-foreground 'highlight "blue")
(set-face-background 'highlight "red")
(set-foreground-color "Green")
(set-background-color "Gray10")
;; Aquamacs: To change the initial frame, you can modify initial-frame-alist
(setq initial-frame-alist '((background-color . "Gray10") (left . 50)  ))                          ;; Required for Aquamacs only, but works on straight OS X Emacs builds too.
;; Preventing Aquamacs from changing those properties when opening additional windows
(setq default-frame-alist '((background-color . "Gray10") (left . 0) (width . 141) (height . 44))) ;; Required for Aquamacs only, but works on straight OS X Emacs builds too.
(set-face-foreground 'font-lock-function-name-face "Turquoise")
(set-face-foreground 'font-lock-keyword-face "Yellow")
(set-face-foreground 'font-lock-string-face "Magenta")
(set-face-foreground 'font-lock-variable-name-face "Coral")
(set-face-attribute 'mode-line nil
   :foreground "yellow"
   :background "purple4")
(set-face-background 'region "MidnightBlue")
(set-face-background 'secondary-selection "dodger blue")
(set-face-foreground 'diary-face "Yellow")
(set-face-background 'holiday-face "Pink")
(set-face-foreground 'holiday-face "Red")
(set-mouse-color "yellow")
;; (set-cursor-color "Deep Pink") ;; See the line just below.
(run-at-time "5 sec" nil (defun set-cursort-color-later() (set-cursor-color "Deep Pink"))) ;; @workaround: Something is overriding this, so I have a timer:

;; You may not want the following line if you do not have paren-matching running:
(set-face-foreground 'show-paren-match-face "Red")

;; The following settings pertain to features that you may not have installed on your GNU Emacs.

;; Set the speedbar pop-up window properties: Note that if the speedbar height is too
;; great, the windowing-system's title bar for the
;; speedbar window (at least on Windows2000) will not show completely.
(setq speedbar-frame-parameters '((width . 30)
                                                                  (height . 45)
                                                                  (foreground-color . "green")
                                                                  (background-color . "black")))
  ;; End speedbar section.

  ;; The following line is only if you have semantic installed:
;; doesn't work for semantic-1.4beta5 (set-face-foreground 'semantic-intangible-face "Gold")
  ;; The following line is only if you have the JDE installed:
;;(set-face-foreground 'jde-java-font-lock-link-face "Gold")

;; - - - - End General Emacs Switches and Functions Section - - - -



;;  ---------  This is SGML colorizing with the psgml package, loaded above.

;;; Set up and enable syntax coloring.
; Create faces  to assign markup categories.
(make-face 'sgml-doctype-face)
(make-face 'sgml-pi-face)
(make-face 'sgml-comment-face)
(make-face 'sgml-sgml-face)
(make-face 'sgml-start-tag-face)
(make-face 'sgml-end-tag-face)
(make-face 'sgml-entity-face)
(make-face 'sgml-attribute-face)

; Assign attributes to faces.
(set-face-foreground 'sgml-doctype-face "yellow")
(set-face-foreground 'sgml-sgml-face "cyan1")
(set-face-foreground 'sgml-pi-face "magenta")
(set-face-foreground 'sgml-comment-face "purple")
(set-face-foreground 'sgml-start-tag-face "deep sky blue")
(set-face-foreground 'sgml-end-tag-face "white")
(set-face-foreground 'sgml-entity-face "orange")

; Assign faces to markup categories.
(setq sgml-markup-faces
      '((doctype        . sgml-doctype-face)
        (pi             . sgml-pi-face)
        (comment        . sgml-comment-face)
        (sgml   . sgml-sgml-face)
        (comment        . sgml-comment-face)
        (start-tag      . sgml-start-tag-face)
        (end-tag        . sgml-end-tag-face)
        (entity . sgml-entity-face)))


; PSGML - enable face settings
(setq sgml-set-face t)

;; ;; ---- End psgml highlighting section.

;; This checks to see if you've set the variable startup-directory and checks to
;; see if you've set it to a real directory.  If so, it will switch there.
(let ((working-directory (or startup-directory nil)))
  (if (and (and working-directory)
    (file-directory-p working-directory))
      (cd working-directory)))

;; ---------- Begin Global Whitespace Section

;; Make sure that tabs are being used (default behavior, but doesn't hurt in case something got changed):
;; (setq indent-tabs-mode t)
;; Make sure that no tab characters are used:
(setq indent-tabs-mode nil)

;; Set the variable default-tab-width.
(setq default-tab-width 4)

;; auto-fill-mode seems to have been turned on by default now in far more places than one would want.
(auto-fill-mode -1)

;; Remove trailing whitespace to avoid extraneous diff results:
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; ---------- End Global Whitespace Section

;; This enables saving the current desktop on shutdown.  The ESC-x desktop-save
;; command must be given once for this to work in perpetuity.
(desktop-save-mode 1)
;; This will save the desktop when Emacs is idle, giving some protection against
;; losing your desktop to a crash.
(add-hook 'auto-save-hook (lambda () (desktop-save-in-desktop-dir)))

;; --------- ** My custom hand-entered additions end here. **

;; --------- ** Begin Auto-written Emacs Customization Section **

;; The following has been automatically written by the Emacs customization utility:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["black" "red" "green" "yellow" "pink" "magenta" "cyan" "white"])
 '(appt-message-warning-time 60 t)
 '(calculator-number-digits 10)
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(dired-recursive-deletes (quote top))
 '(display-time-mode t)
 '(font-use-system-font t)
 '(frame-background-mode nil)
 '(global-font-lock-mode t nil (font-lock))
 '(indent-tabs-mode nil)
 '(mail-host-address "")
 '(midnight-delay 34200)
 '(midnight-hook (quote (update-my-calendar)))
 '(midnight-mode t nil (midnight))
 '(printer-name "USB001")
 '(show-paren-mode t nil (paren))
 '(speedbar-show-unknown-files t)
 '(speedbar-use-images t)
 '(standard-indent 4)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style nil nil (uniquify))
 '(user-full-name "Christopher M. Balz")
 '(w3-default-homepage "http://www.yahoo.com")
 '(which-function-mode nil nil (which-func)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(speedbar-button-face ((t (:background "black" :foreground "deep sky blue"))))
 '(speedbar-file-face ((t (:background "black" :foreground "yellow1"))))
 '(speedbar-selected-face ((((class color) (background dark)) (:background "black" :foreground "red" :underline t))))
 '(speedbar-tag-face ((t (:background "black" :foreground "Orange")))))
