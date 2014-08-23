#lang racket
(require racket/block)

(define main
  (let ([e 2])
  (let ([f 3])
  (let ([g 4])
  (block
    (map display (list (min e f g) " "))
    (let ([i 2])
    (let ([j 4])
    (let ([k 3])
    (block
      (map display (list (min i j k) " "))
      (let ([m 3])
      (let ([n 2])
      (let ([o 4])
      (block
        (map display (list (min m n o) " "))
        (let ([q 3])
        (let ([r 4])
        (let ([s 2])
        (block
          (map display (list (min q r s) " "))
          (let ([v 4])
          (let ([w 2])
          (let ([x 3])
          (block
            (map display (list (min v w x) " "))
            (let ([z 4])
            (let ([ba 3])
            (let ([bb 2])
            (block
              (map display (list (min z ba bb) "\n"))
              ))))
            ))))
          ))))
        ))))
      ))))
    ))))
)

