#lang racket
(require racket/block)

(define (read_int _)
  ;toto
  (string->number (read-line))
)
(define (read_int_line n)
  ;toto
  (list->vector (map string->number (regexp-split " " (read-line))))
)
(define (read_char_line n)
  ;toto
  (list->vector (string->list (read-line)))
)
(define main
  (let ([len (read_int 'nil)])
  (block
    (map display (list len "=len\n"))
    (let ([tab (read_int_line len)])
    (let ([o 0])
    (let ([p (- len 1)])
    (letrec ([m (lambda (i) 
                  (if (<= i p)
                  (block
                    (map display (list i "=>" (vector-ref tab i) " "))
                    (m (+ i 1))
                    )
                  (block
                    (display "\n")
                    (let ([tab2 (read_int_line len)])
                    (let ([k 0])
                    (let ([l (- len 1)])
                    (letrec ([h (lambda (i_) 
                                  (if (<= i_ l)
                                  (block
                                    (map display (list i_ "==>" (vector-ref tab2 i_) " "))
                                    (h (+ i_ 1))
                                    )
                                  (let ([strlen (read_int 'nil)])
                                  (block
                                    (map display (list strlen "=strlen\n"))
                                    (let ([tab4 (read_char_line strlen)])
                                    (let ([f 0])
                                    (let ([g (- strlen 1)])
                                    (letrec ([e (lambda (i3) 
                                                  (if (<= i3 g)
                                                  (let ([tmpc (vector-ref tab4 i3)])
                                                  (let ([c (char->integer tmpc)])
                                                  (block
                                                    (map display (list tmpc ":" c " "))
                                                    (let ([c (if (not (eq? tmpc #\Space))
                                                             (let ([c (+ (remainder (+ (- c (char->integer #\a)) 13) 26) (char->integer #\a))])
                                                             c)
                                                             c)])
                                                    (block
                                                      (vector-set! tab4 i3 (integer->char c))
                                                      (e (+ i3 1))
                                                      ))
                                                    )))
                                                  (let ([b 0])
                                                  (let ([d (- strlen 1)])
                                                  (letrec ([a (lambda (j) 
                                                                (if (<= j d)
                                                                (block
                                                                  (display (vector-ref tab4 j))
                                                                  (a (+ j 1))
                                                                  )
                                                                '()))])
                                                  (a b))))))])
                                    (e f)))))
                                  ))))])
                    (h k)))))
      )))])
    (m o)))))
))
)

