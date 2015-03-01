#lang racket
(require racket/block)

(define main
  (let ([j 0])
  (let ([j 0])
  (block
    (printf "~a\n" j)
    (let ([j 1])
    (block
      (printf "~a\n" j)
      (let ([j 2])
      (block
        (printf "~a\n" j)
        (let ([j 3])
        (block
          (printf "~a\n" j)
          (let ([j 4])
          (printf "~a\n" j))
          ))
        ))
      ))
    )))
)

