;;;; advent2022.asd

(asdf:defsystem #:advent2022
  :description "Advent of Code 2022"
  :author "Stefano Rodighiero <stefano.rodighiero@gmail.com>"
  :version "0.0.1"
  :serial t
  :depends-on (#:alexandria #:cl-ppcre #:split-sequence #:sketch)
  :components ((:file "package")))

(asdf:defsystem #:advent2022/test
  :depends-on (#:advent2022
               #:parachute)
  :components ((:module "tests"
                :components ((:file "package")
                             (:file "main"))))
  :perform (test-op (op _) (symbol-call :parachute :test :advent2022/test)))
