#lang racket
(require racket/block)

(define main
  (let ([b 4])
  (let ([a (integer-sqrt b)])
  (block
    (map display (list a " "))
    (let ([e 16])
    (let ([d (integer-sqrt e)])
    (block
      (map display (list d " "))
      (let ([g 20])
      (let ([f (integer-sqrt g)])
      (block
        (map display (list f " "))
        (let ([i 1000])
        (let ([h (integer-sqrt i)])
        (block
          (map display (list h " "))
          (let ([k 500])
          (let ([j (integer-sqrt k)])
          (block
            (map display (list j " "))
            (let ([m 10])
            (let ([l (integer-sqrt m)])
            (block
              (map display (list l " "))
              )))
            )))
          )))
        )))
      )))
    )))
)

