(in-package #:advent2022)

(defun read-calories-groups ()
  (split-sequence nil (mapcar (lambda (str)
                                (parse-integer str :junk-allowed t))
                              (uiop:read-file-lines
                               (asdf:system-relative-pathname :advent2022 "inputs/day1-test")))))

(defun sum (lst)
  (reduce #'+ lst))

(defun day1/solution1 ()
  (loop for cg in (read-calories-groups)
        maximizing (sum cg)))

(defun day1/solution2 ()
  (sum (subseq
        (sort (mapcar #'sum (read-calories-groups)) #'>)
        0 3)))
