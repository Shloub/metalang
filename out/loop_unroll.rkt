#lang racket
(require racket/block)

(define main
  (let ([j 0])
  (let ([j 0])
  (block
    (map display (list j "\n"))
    (let ([j 1])
    (block
      (map display (list j "\n"))
      (let ([j 2])
      (block
        (map display (list j "\n"))
        (let ([j 3])
        (block
          (map display (list j "\n"))
          (let ([j 4])
          (block
            (map display (list j "\n"))
            ))
          ))
        ))
      ))
    )))
)

