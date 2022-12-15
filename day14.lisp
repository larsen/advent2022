(in-package #:advent2022)

(defsketch cave-monitor ((grains '())
                         (cave-scan (read-cave-scan))
                         (width 1200)
                         (height 600))
  (background (rgb 0 0 0))
  ;; Draw rocks
  (with-pen (make-pen :stroke (rgb 0 1 0) :weight 2)
    (loop for wall in cave-scan
          do (apply #'polyline (loop for w in wall
                                     append (mapcar (lambda (n) (* n 2)) w)))))
  ;; Draw sand
  (with-pen (make-pen :stroke (rgb 1 0 0))
    (loop for g in grains
          do (rect (* 2 (car g)) (* 2 (cdr g)) 2 2))))


(defun read-cave-scan ()
  (loop for l in (uiop:read-file-lines
                  (asdf:system-relative-pathname :advent2022 "inputs/day14"))
        collect (mapcar (lambda (s)
                          (mapcar #'parse-integer (split "," s)))
                        (split " -> " l))))

(define-condition new-grain-of-sand ()
  ((x :initarg :x :accessor grain-x)
   (y :initarg :y :accessor grain-y)))

(defun setup-rocks-in-cave (cave cave-scan)
  (loop for wall in cave-scan
        do (loop for idx from 1 below (length wall)
                 for p1 = (nth (- idx 1) wall)
                 for p2 = (nth idx wall)
                 when (= (first p1) (first p2))
                   do (loop for y from (min (second p1) (second p2)) to (max (second p1) (second p2))
                            do (setf (aref cave y (first p1)) :wall))

                 when (= (second p1) (second p2))
                   do (loop for x from (min (first p1) (first p2)) to (max (first p1) (first p2))
                            do (setf (aref cave (second p1) x) :wall))))
  cave)

(defun day14/solution1 ()
  (let* ((cave-scan (read-cave-scan))
         (cave-shape '(1200 600))
         (cave (make-array cave-shape :initial-element :empty))
         (cave (setup-rocks-in-cave cave cave-scan)))

    (block :10
      (loop for counter from 0
            for grain = '(500 0)
            for grain-rest = nil
            do (loop while (not grain-rest)
                     for dest = (loop for (dx dy) in '((0 1) (-1 1) (1 1))
                                      when (and
                                            (array-in-bounds-p cave
                                                               (+ dy (second grain))
                                                               (+ dx (first grain)))
                                            (eq :empty (aref cave
                                                             (+ dy (second grain))
                                                             (+ dx (first grain)))))
                                        return (list (+ dx (first grain))
                                                     (+ dy (second grain)))
                                      finally (return grain))
                     when (not (array-in-bounds-p cave
                                                  (+ 1 (second dest))
                                                  (first dest)))
                       do (return-from :10 counter)
                     do (if (equal dest grain)
                            (progn
                              (setf grain-rest t)
                              (setf (aref cave (second grain) (first grain)) :sand)
                              (signal 'new-grain-of-sand :x (first grain)
                                                         :y (second grain)))
                            (setf grain dest)))))))


(defun day14/solution2 ()
  (let* ((cave-scan (read-cave-scan))
         (floor-level (+ 2 (apply #'max (mapcar #'second (loop for wall in cave-scan
                                                               append wall)))))
         (cave-shape '(1200 1200))
         (cave (make-array cave-shape :initial-element :empty))
         (cave (setup-rocks-in-cave cave cave-scan)))

    (apply #'max (mapcar #'second (loop for wall in cave-scan
                                        append wall)))

    (block :10
      (loop for counter from 1
            for grain = '(500 0)
            for grain-rest = nil
            do (loop while (not grain-rest)
                     for dest = (loop for (dx dy) in '((0 1) (-1 1) (1 1))
                                      when (and
                                            (< (+ dy (second grain)) floor-level)
                                            (eq :empty (aref cave
                                                             (+ dy (second grain))
                                                             (+ dx (first grain)))))
                                        return (list (+ dx (first grain))
                                                     (+ dy (second grain)))
                                      finally (return grain))
                     when (and (= 500 (first dest))
                               (= 0 (second dest)))
                       do (return-from :10 counter)
                     do (if (equal dest grain)
                            (progn
                              (setf grain-rest t)
                              (setf (aref cave (second grain) (first grain)) :sand)
                              (signal 'new-grain-of-sand :x (first grain)
                                                         :y (second grain)))
                            (setf grain dest)))))))

(defun cave-simulation ()
  (let ((m (make-instance 'cave-monitor)))
    (handler-bind ((new-grain-of-sand (lambda (g)
                                        (push (cons (grain-x g)
                                                    (grain-y g))
                                              (cave-monitor-grains m))
                                        (sleep 0.05))))
      (day14/solution2))))
