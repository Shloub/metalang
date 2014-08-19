#lang racket
(require racket/block)

(define main
  (let ([j 0])
  (let ([j 0])
  (block
    (display j)
    (display "\n")
    (let ([j 1])
    (block
      (display j)
      (display "\n")
      (let ([j 2])
      (block
        (display j)
        (display "\n")
        (let ([j 3])
        (block
          (display j)
          (display "\n")
          (let ([j 4])
          (block
            (display j)
            (display "\n")
            ))
          ))
        ))
      ))
    )))
)

