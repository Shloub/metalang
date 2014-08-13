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

(define main (let ([i 0])
               (let ([i (- i 1)])
                 (block
                   (display i)
                   (display "\n")
                   (let ([i (+ i 55)])
                     (block
                       (display i)
                       (display "\n")
                       (let ([i (* i 13)])
                         (block
                           (display i)
                           (display "\n")
                           (let ([i (quotient i 2)])
                             (block
                               (display i)
                               (display "\n")
                               (let ([i (+ i 1)])
                                 (block
                                   (display i)
                                   (display "\n")
                                   (let ([i (quotient i 3)])
                                     (block
                                       (display i)
                                       (display "\n")
                                       (let ([i (- i 1)])
                                         (block
                                           (display i)
                                           (display "\n")
                                           ;
                                           ;http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
                                           ;
                                           (block
                                             (display (quotient 117 17))
                                             (display "\n")
                                             (display (quotient 117 (- 17)))
                                             (display "\n")
                                             (display (quotient (- 117) 17))
                                             (display "\n")
                                             (display (quotient (- 117) (- 17)))
                                             (display "\n")
                                             (display (remainder 117 17))
                                             (display "\n")
                                             (display (remainder 117 (- 17)))
                                             (display "\n")
                                             (display (remainder (- 117) 17))
                                             (display "\n")
                                             (display (remainder (- 117) (- 17)))
                                             (display "\n")
                                             )
                                           ))
                                       ))
                                   ))
                               ))
                           ))
                       ))
                   ))))

