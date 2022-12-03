(in-package #:advent2022/test)

(define-test day1
  (is = (day1/solution1) 69693)
  (is = (day1/solution2) 200945))

;; (define-test day2
;;   (is = (day2/solution1) 11386)
;;   (is = (day2/solution2) 13600))

(define-test day3
  (is = (day3/solution1) 7817)
  (is = (day3/solution2) 2444))
