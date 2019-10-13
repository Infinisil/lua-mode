;; -*- flycheck-disabled-checkers: (emacs-lisp-checkdoc) -*-

(load (concat (file-name-directory (or load-file-name (buffer-file-name)
                                       default-directory))
              "utils.el") nil 'nomessage 'nosuffix)

(require 'lua-mode)


(describe "Test lua-rx forms"
  (it "expands symbol form"
    (expect
     (lua-rx-to-string '(symbol "foo") t)
     :to-equal "\\_<foo\\_>")
    (expect
     (lua-rx-to-string '(symbol "foo" "bar") t)
     :to-equal "\\_<\\(?:bar\\|foo\\)\\_>"))
  (it "expands whitespace forms"
    (expect
     (lua-rx-to-string 'ws t)
     :to-equal "[\t ]*")
    (expect
     (lua-rx-to-string 'ws+ t)
     :to-equal "[\t ]+"))

  (it "expands lua-name"
    (expect
     (lua-rx-to-string 'lua-name t)
     :to-equal "\\_<[_[:alpha:]]+[_[:alnum:]]*\\_>"))
  (it "expands lua-funcname"
    (expect
     (lua-rx-to-string 'lua-funcname t)
     :to-equal "\\_<[_[:alpha:]]+[_[:alnum:]]*\\_>\\(?:[\t ]*\\.[\t ]*\\_<[_[:alpha:]]+[_[:alnum:]]*\\_>\\)*\\(?:[\t ]*:[\t ]*\\_<[_[:alpha:]]+[_[:alnum:]]*\\_>\\)?"))
  (it "expands lua-funcheader"
    (expect
     (lua-rx-to-string 'lua-funcheader t)
     :to-equal "\\_<function\\_>[\t ]*\\(?1:\\_<[_[:alpha:]]+[_[:alnum:]]*\\_>\\(?:[\t ]*\\.[\t ]*\\_<[_[:alpha:]]+[_[:alnum:]]*\\_>\\)*\\(?:[\t ]*:[\t ]*\\_<[_[:alpha:]]+[_[:alnum:]]*\\_>\\)?\\)\\|\\(?1:\\_<[_[:alpha:]]+[_[:alnum:]]*\\_>\\(?:[\t ]*\\.[\t ]*\\_<[_[:alpha:]]+[_[:alnum:]]*\\_>\\)*\\(?:[\t ]*:[\t ]*\\_<[_[:alpha:]]+[_[:alnum:]]*\\_>\\)?\\)[\t ]*=[\t ]*\\_<function\\_>"))
  (it "expands lua-number"
    (expect
     (lua-rx-to-string 'lua-number t)
     :to-equal "\\(?:[[:digit:]]+\\.?[[:digit:]]*\\|[[:digit:]]*\\.?[[:digit:]]+\\)\\(?:[eE][+-]?[0-9]+\\)?"))
  (it "expands lua-assignment-op"
    (expect
     (lua-rx-to-string 'lua-assignment-op t)
     :to-equal "=\\(?:\\'\\|[^=]\\)"))
  (it "expands lua-token"
    (expect
     (lua-rx-to-string 'lua-token t)
     :to-equal "\\(?:\\+\\|-\\|\\*\\|/\\|%\\|\\^\\|#\\|==\\|~=\\|<=\\|>=\\|<\\|>\\|=\\|;\\|:\\|,\\|\\.\\|\\.\\.\\|\\.\\.\\.\\)"))
  (it "expands lua-keyword"
    (expect
     (lua-rx-to-string 'lua-keyword t)
     :to-equal "\\_<\\(?:and\\|break\\|do\\|else\\|elseif\\|end\\|for\\|function\\|goto\\|if\\|in\\|local\\|not\\|or\\|repeat\\|return\\|then\\|until\\|while\\)\\_>")))


;; (cl-loop for b in lua--rx-bindings
;;          for form-sym = (car b)
;;          if (not (eq 'symbol form-sym))
;;          collect `(it ,(concat "expands " (symbol-name form-sym))
;;                     (expect (lua-rx-to-string (quote ,form-sym) t)
;;                             :to-equal ,(lua-rx-to-string form-sym t))))
;; ;


