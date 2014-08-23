#lang racket
(require racket/block)

(define main
  (let ([b 4])
  (block
    (map display (list (integer-sqrt b) " "))
    (let ([e 16])
    (block
      (map display (list (integer-sqrt e) " "))
      (let ([g 20])
      (block
        (map display (list (integer-sqrt g) " "))
        (let ([i 1000])
        (block
          (map display (list (integer-sqrt i) " "))
          (let ([k 500])
          (block
            (map display (list (integer-sqrt k) " "))
            (let ([m 10])
            (block
              (map display (list (integer-sqrt m) " "))
              ))
            ))
          ))
        ))
      ))
    ))
)

