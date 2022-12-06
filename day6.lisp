(in-package #:advent2022)



;;    bvwbjplbgvbhsrlpgdmjqwftvncz: first marker after character 5
;;    nppdvjthqldpwncqszvftbrmjlhg: first marker after character 6
;;    nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg: first marker after character 10
;;    zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw: first marker after character 11

(defun read-signal-buffer ()
  (uiop:read-file-string (asdf:system-relative-pathname :advent2022 "inputs/day6")))

(defun all-different-p (sequence)
  (= (length sequence)
     (length (remove-duplicates sequence))))

(defun detect-marker (buffer marker-length)
  (loop for pos from marker-length below (length buffer)
        when (all-different-p (subseq buffer (- pos marker-length) pos))
          return pos))

(defun day6/solution1 ()
  (detect-marker (read-signal-buffer) 4))

(defun day6/solution2 ()
  (detect-marker (read-signal-buffer) 14))
