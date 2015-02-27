#lang racket
(require racket/block)
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

(define (position_alphabet c)
  ;toto
  (let ([i (char->integer c)])
  (if (and (<= i (char->integer #\Z)) (>= i (char->integer #\A)))
  (- i (char->integer #\A))
  (if (and (<= i (char->integer #\z)) (>= i (char->integer #\a)))
  (- i (char->integer #\a))
  (- 1))))
)
(define (of_position_alphabet c)
  ;toto
  (integer->char (+ c (char->integer #\a)))
)
(define (crypte taille_cle cle taille message)
  ;toto
  (let ([b (- taille 1)])
  (letrec ([a (lambda (i) 
                (if (<= i b)
                (let ([lettre (position_alphabet (vector-ref message i))])
                (if (not (eq? lettre (- 1)))
                (let ([addon (position_alphabet (vector-ref cle (remainder i taille_cle)))])
                (let ([new0 (remainder (+ addon lettre) 26)])
                (block
                  (vector-set! message i (of_position_alphabet new0))
                  (a (+ i 1))
                  )))
                (a (+ i 1))))
                '()))])
  (a 0)))
)
(define main
  ((lambda (taille_cle) 
     (block
       (mread-blank)
       (let ([cle (build-vector taille_cle (lambda (index) 
                                             ((lambda (out0) 
                                                out0) (mread-char))))])
     (block
       (mread-blank)
       ((lambda (taille) 
          (block
            (mread-blank)
            (let ([message (build-vector taille (lambda (index2) 
                                                  ((lambda (out2) 
                                                     out2) (mread-char))))])
          (block
            (crypte taille_cle cle taille message)
            (let ([j (- taille 1)])
            (letrec ([h (lambda (i) 
                          (if (<= i j)
                          (block
                            (display (vector-ref message i))
                            (h (+ i 1))
                            )
                          (display "\n")))])
            (h 0)))
          ))
     )) (mread-int))
))
)) (mread-int))
)

