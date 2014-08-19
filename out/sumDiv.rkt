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
  (block
    (if (eq? 1 1)
    '()
    '())
    '()
    )
)
(define (sumdiv n)
  ;toto
  ; On désire renvoyer la somme des diviseurs 
  (let ([out_ 0])
  ; On déclare un entier qui contiendra la somme 
  (let ([c 1])
  (let ([d n])
  (letrec ([b (lambda (i out_) 
                (if (<= i d)
                ; La boucle : i est le diviseur potentiel
                (let ([out_ (if (eq? (remainder n i) 0)
                            ; Si i divise 
                            (let ([out_ (+ out_ i)])
                            ; On incrémente 
                            out_)
                            ; nop 
                            out_)])
                (b (+ i 1) out_))
                out_))])
  (b c out_)))))
)
(define main
  ; Programme principal 
  (let ([n 0])
  ((lambda (e) 
     (let ([n e])
     ; Lecture de l'entier 
     (display (sumdiv n)))) (mread-int)))
)

