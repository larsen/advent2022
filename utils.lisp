(in-package #:advent2022)

(defun sum (lst)
  (reduce #'+ lst))

(defun transpose (lst)
  (apply #'mapcar #'list lst))
