;;;; advent2022.asd

(asdf:defsystem #:advent2022
  :description "Advent of Code 2022"
  :author "Stefano Rodighiero <stefano.rodighiero@gmail.com>"
  :version "0.0.1"
  :serial t
  :depends-on (#:alexandria #:cl-ppcre #:split-sequence #:sketch)
  :components ((:file "package")
               (:file "utils")
               (:file "day1" :depends-on ("utils"))
               (:file "day2")
               (:file "day3")
               (:file "day4")
               (:file "day5" :depends-on ("utils"))
               (:file "day6")
               (:file "day7" :depends-on ("utils"))
               (:file "day8")
               (:file "day9")
               (:file "day10" :depends-on ("utils"))
               (:file "day11")
               (:file "day12" :depends-on ("utils"))
               (:file "day13"))
  :in-order-to ((test-op (test-op #:advent2022/test))))

(asdf:defsystem #:advent2022/test
  :depends-on (#:advent2022
               #:parachute)
  :components ((:module "tests"
                :components ((:file "package")
                             (:file "main"))))
  :perform (test-op (op _) (symbol-call :parachute :test :advent2022/test)))
