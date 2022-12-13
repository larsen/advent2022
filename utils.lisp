(in-package #:advent2022)

(defparameter infinity most-positive-fixnum)

(defun sum (lst)
  (reduce #'+ lst))

(defun transpose (lst)
  (apply #'mapcar #'list lst))
