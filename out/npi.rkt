#lang racket
(require racket/block)
(define array_init_withenv (lambda (len f env)
  (let ((tab (build-vector len (lambda (i)
    (let ([o ((f i) env)])
      (block
        (set! env (car o))
        (cadr o)
      )
    ))))) (list env tab))))
(define last-char 0)
(define next-char (lambda () (set! last-char (read-char (current-input-port)))))
(next-char)
(define mread-char (lambda ()
  (let ([ out last-char])
    (block
      (next-char)
      out
    ))))
(define mread-int (lambda ()
  (if (eq? #\- last-char)
  (block
    (next-char) (- 0 (mread-int)))
    (letrec ([w (lambda (out)
      (if (eof-object? last-char)
        out
        (if (and last-char (>= (char->integer last-char) (char->integer #\0)) (<= (char->integer last-char) (char->integer #\9)))
          (let ([out (+ (* 10 out) (- (char->integer last-char) (char->integer #\0)))])
            (block
              (next-char)
              (w out)
          ))
        out
      )))]) (w 0)))))
(define mread-blank (lambda ()
  (if (or (eq? last-char #\NewLine) (eq? last-char #\Space) ) (block (next-char) (mread-blank)) '())
))

(define (is_number c)
  ;toto
  (and (<= (char->integer c) (char->integer #\9)) (>= (char->integer c) (char->integer #\0)))
)
(define (npi0 str len)
  ;toto
  ((lambda (internal_env) (apply (lambda (b stack) 
                                        (block
                                          b
                                          (let ([ptrStack 0])
                                          (let ([ptrStr 0])
                                          (letrec ([d (lambda (ptrStack ptrStr) 
                                                        (if (< ptrStr len)
                                                        (if (eq? (vector-ref str ptrStr) #\Space)
                                                        (let ([ptrStr (+ ptrStr 1)])
                                                        (d ptrStack ptrStr))
                                                        (if (is_number (vector-ref str ptrStr))
                                                        (let ([num 0])
                                                        (letrec ([e (lambda (num ptrStr) 
                                                                      (if (not (eq? (vector-ref str ptrStr) #\Space))
                                                                      (let ([num (- (+ (* num 10) (char->integer (vector-ref str ptrStr))) (char->integer #\0))])
                                                                      (let ([ptrStr (+ ptrStr 1)])
                                                                      (e num ptrStr)))
                                                                      (block
                                                                        (vector-set! stack ptrStack num)
                                                                        (let ([ptrStack (+ ptrStack 1)])
                                                                        (d ptrStack ptrStr))
                                                                        )))])
                                                        (e num ptrStr)))
                                                        (if (eq? (vector-ref str ptrStr) (integer->char 43))
                                                        (block
                                                          (vector-set! stack (- ptrStack 2) (+ (vector-ref stack (- ptrStack 2)) (vector-ref stack (- ptrStack 1))))
                                                          (let ([ptrStack (- ptrStack 1)])
                                                          (let ([ptrStr (+ ptrStr 1)])
                                                          (d ptrStack ptrStr)))
                                                          )
                                                        (d ptrStack ptrStr))))
                                                        (vector-ref stack 0)))])
                                          (d ptrStack ptrStr))))
  )) internal_env)) (array_init_withenv len (lambda (i) 
                                              (lambda (_) (let ([a 0])
                                                          (list '() a)))) '()))
)
(define main
  (let ([len 0])
  ((lambda (j) 
     (let ([len j])
     (block
       (mread-blank)
       ((lambda (internal_env) (apply (lambda (g tab) 
                                             (block
                                               g
                                               (let ([result (npi0 tab len)])
                                               (display result))
                                               )) internal_env)) (array_init_withenv len 
       (lambda (i) 
         (lambda (_) (let ([tmp (integer->char 0)])
                     ((lambda (h) 
                        (let ([tmp h])
                        (let ([f tmp])
                        (list '() f)))) (mread-char))))) '()))
     ))) (mread-int)))
)

