#lang racket
(require racket/block)
(define last-char 0)
(define next-char (lambda () (set! last-char (read-char (current-input-port)))))
(next-char)
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

(define (foo _)
  ;toto
  (let ([a 0])
  ; test 
  (let ([a (+ a 1)])
  ; test 2 
  '()))
)
(define (foo2 _)
  ;toto
  '()
)
(define (foo3 _)
  ;toto
  (if (eq? 1 1)
  '()
  '())
)
(define (sumdiv n)
  ;toto
  ; On désire renvoyer la somme des diviseurs 
  (let ([out0 0])
  ; On déclare un entier qui contiendra la somme 
  (letrec ([b (lambda (i out0) 
                (if (<= i n)
                ; La boucle : i est le diviseur potentiel
                (if (eq? (remainder n i) 0)
                ; Si i divise 
                (let ([out0 (+ out0 i)])
                ; On incrémente 
                (b (+ i 1) out0))
                ; nop 
                (b (+ i 1) out0))
                out0))])
  (b 1 out0)))
)
(define main
  ; Programme principal 
  (let ([n 0])
  ((lambda (c) 
     (let ([n c])
     ; Lecture de l'entier 
     (display (sumdiv n)))) (mread-int)))
)

