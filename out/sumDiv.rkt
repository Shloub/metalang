#lang racket
(require racket/block)

(define array_init_withenv (lambda (len f env)
  (build-vector len (lambda (i)
    (let ([o ((f i) env)])
      (block
        (set! env (car o))
        (cadr o)
      )
    )))))
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

(define foo (lambda () 
              (let ([a 0])
                ; test 
                (let ([a (+ a 1)])
                  ; test 2 
                  '()))))
(define foo2 (lambda () 
               '()))
(define foo3 (lambda () 
               (let ([f (lambda () 
                          '())])
               (if (eq? 1 1)
                 (f )
                 (f )))))
(define sumdiv (lambda (n) 
                 ; On désire renvoyer la somme des diviseurs 
                 (let ([out_ 0])
                   ; On déclare un entier qui contiendra la somme 
                   (let ([d 1])
                     (let ([e n])
                       (letrec ([b (lambda (i out_ n) 
                                     (if (<= i e)
                                       ; La boucle : i est le diviseur potentiel
                                       (let ([c (lambda (out_ n) 
                                                  (b (+ i 1) out_ n))])
                                       (if (eq? (remainder n i) 0)
                                         ; Si i divise 
                                         (let ([out_ (+ out_ i)])
                                           ; On incrémente 
                                           (c out_ n))
                                         ; nop 
                                         (c out_ n)))
                                     out_))])
                     (b d out_ n)))))))
(define main ; Programme principal 
  (let ([n 0])
    ((lambda (g) 
       (let ([n g])
         ; Lecture de l'entier 
         (display (sumdiv n)))) (mread-int))))

