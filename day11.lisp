(in-package #:advent2022)


;; Monkey 0:
;;   Starting items: 79, 98
;;   Operation: new = old * 19
;;   Test: divisible by 23
;;     If true: throw to monkey 2
;;     If false: throw to monkey 3

;; 10605

(defstruct monkey
  (identifier)
  (items '())
  (operation-f)
  (operation-operand)
  (divisibility-test)
  (test-true-dest)
  (test-false-dest)
  (items-inspected 0))

(defmethod print-object ((m monkey) stream)
  (with-slots (identifier items operation-f operation-operand items-inspected) m
    (format stream "ID:~a ~{~a~^, ~} f:~a~a~% (inspected ~a)"
            identifier
            items
            operation-f
            operation-operand
            items-inspected)))

(defun monkey-from-string (str)
  (register-groups-bind ((#'parse-integer id)
                         items
                         operation-f
                         operation-operand
                         (#'parse-integer divisibility-test
                                          test-true-dest
                                          test-false-dest))
      ("Monkey (\\d+):
  Starting items: (.+)
  Operation: new = old (.) (.+)
  Test: divisible by (\\d+)
    If true: throw to monkey (\\d+)
    If false: throw to monkey (\\d+)" str)
    (make-monkey :identifier id
                 :items (mapcar #'parse-integer (split ", ?" items))
                 :operation-f operation-f
                 :operation-operand operation-operand
                 :divisibility-test divisibility-test
                 :test-true-dest test-true-dest
                 :test-false-dest test-false-dest)))

(defmethod throw-item (item (to monkey))
  (setf (monkey-items to) (nconc (monkey-items to) (list item))))

(defmethod apply-operation (item (m monkey))
  (with-slots (operation-f operation-operand) m
    (funcall (intern operation-f)
             item
             (if (string= "old" operation-operand)
                 item
                 (parse-integer operation-operand)))))

(defmethod test-divisibility (item (m monkey))
  (zerop (mod item (monkey-divisibility-test m))))

(defun read-monkeys-team ()
  (mapcar #'monkey-from-string
          (split "\\n\\n"
                 (uiop:read-file-string
                  (asdf:system-relative-pathname :advent2022 "inputs/day11")))))

(defun day11/solution1 ()
  (let ((team (read-monkeys-team)))
    (loop repeat 20
          do (loop for m in team
                   do (loop while (monkey-items m)
                            for item = (pop (monkey-items m))
                            do (incf (monkey-items-inspected m))
                               (setf item (floor (/ (apply-operation item m) 3)))
                               (if (test-divisibility item m)
                                   (throw-item item (nth (monkey-test-true-dest m)
                                                         team))
                                   (throw-item item (nth (monkey-test-false-dest m)
                                                         team)))))
          finally (return (apply #'* (subseq
                                      (sort
                                       (mapcar #'monkey-items-inspected team) #'>)
                                      0 2))))))

(defun day11/solution2 ()
  )
