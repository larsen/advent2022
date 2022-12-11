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

(define-test day6
  (is = (day6/solution1) 1658)
  (is = (day6/solution2) 2260))

(define-test day7
  (is = (day7/solution1) 1315285)
  (is = (day7/solution2) 9847279))

(define-test day8
  (is = (day8/solution1) 1825)
  (is = (day8/solution2) 235200))

(define-test day9
  (is = (day9/solution1) 5874)
  (is = (day9/solution2) 2467))

(define-test day10
  (is = (day10/solution1) 14860)
  (is string= (day10/solution2) "RGZEHURK"))

(define-test day11
  (is = (day11/solution1) 50830))
