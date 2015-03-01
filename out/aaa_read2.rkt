#lang racket
(require racket/block)

(define main
  (let ([len (string->number (read-line))])
  (block
    (printf "~a=len\n" len)
    (let ([tab (list->vector (map string->number (regexp-split " " (read-line))))])
    (letrec ([e (lambda (i) 
                  (if (<= i (- len 1))
                  (block
                    (printf "~a=>~a " i (vector-ref tab i))
                    (e (+ i 1))
                    )
                  (block
                    (display "\n")
                    (let ([tab2 (list->vector (map string->number (regexp-split " " (read-line))))])
                    (letrec ([d (lambda (i_) 
                                  (if (<= i_ (- len 1))
                                  (block
                                    (printf "~a==>~a " i_ (vector-ref tab2 i_))
                                    (d (+ i_ 1))
                                    )
                                  (let ([strlen (string->number (read-line))])
                                  (block
                                    (printf "~a=strlen\n" strlen)
                                    (let ([tab4 (list->vector (string->list (read-line)))])
                                    (letrec ([b (lambda (i3) 
                                                  (if (<= i3 (- strlen 1))
                                                  (let ([tmpc (vector-ref tab4 i3)])
                                                  (let ([c (char->integer tmpc)])
                                                  (block
                                                    (printf "~c:~a " tmpc c)
                                                    (let ([c (if (not (eq? tmpc #\Space))
                                                             (let ([c (+ (remainder (+ (- c (char->integer #\a)) 13) 26) (char->integer #\a))])
                                                             c)
                                                             c)])
                                                    (block
                                                      (vector-set! tab4 i3 (integer->char c))
                                                      (b (+ i3 1))
                                                      ))
                                                    )))
                                                  (letrec ([a (lambda (j) 
                                                                (if (<= j (- strlen 1))
                                                                (block
                                                                  (display (vector-ref tab4 j))
                                                                  (a (+ j 1))
                                                                  )
                                                                '()))])
                                                  (a 0))))])
                                    (b 0)))
                                  ))))])
                  (d 0)))
      )))])
  (e 0)))
))
)

