(in-package #:advent2022/test)

(define-test day1
  (is = (day1/solution1) 69693)
  (is = (day1/solution2) 200945))

(define-test day2
  (is = (day2/solution1) 11386)
  (is = (day2/solution2) 13600))

(define-test day3
  (is = (day3/solution1) 7817)
  (is = (day3/solution2) 2444))

(define-test day4
  (is = (day4/solution1) 573)
  (is = (day4/solution2) 867))

(define-test day5
  (is string= (day5/solution1) "WHTLRMZRC")
  (is string= (day5/solution2) "GMPMLWNMG"))
