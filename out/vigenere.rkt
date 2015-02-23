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

(define (position_alphabet c)
  ;toto
  (let ([i (char->integer c)])
  (let ([e (lambda (_) 
             '())])
  (if (and (<= i (char->integer #\Z)) (>= i (char->integer #\A)))
  (- i (char->integer #\A))
  (let ([f (lambda (_) 
             (e 'nil))])
  (if (and (<= i (char->integer #\z)) (>= i (char->integer #\a)))
  (- i (char->integer #\a))
  (- 1))))))
)
(define (of_position_alphabet c)
  ;toto
  (integer->char (+ c (char->integer #\a)))
)
(define (crypte taille_cle cle taille message)
  ;toto
  (let ([b 0])
  (let ([d (- taille 1)])
  (letrec ([a (lambda (i) 
                (if (<= i d)
                (let ([lettre (position_alphabet (vector-ref message i))])
                (block
                  (if (not (eq? lettre (- 1)))
                  (let ([addon (position_alphabet (vector-ref cle (remainder i taille_cle)))])
                  (let ([new0 (remainder (+ addon lettre) 26)])
                  (vector-set! message i (of_position_alphabet new0))))
                  '())
                  (a (+ i 1))
                  ))
                '()))])
  (a b))))
)
(define main
  ((lambda (taille_cle) 
     (block
       (mread-blank)
       ((lambda (internal_env) (apply (lambda (h cle) 
                                             (block
                                               h
                                               (mread-blank)
                                               ((lambda (taille) 
                                                  (block
                                                    (mread-blank)
                                                    ((lambda (internal_env) (apply (lambda
                                                     (k message) 
                                                    (block
                                                      k
                                                      (crypte taille_cle cle taille message)
                                                      (let ([m 0])
                                                      (let ([n (- taille 1)])
                                                      (letrec ([l (lambda (i) 
                                                                    (if (<= i n)
                                                                    (block
                                                                      (display (vector-ref message i))
                                                                      (l (+ i 1))
                                                                      )
                                                                    (display "\n")))])
                                                      (l m))))
                                                    )) internal_env)) (array_init_withenv taille 
                                                  (lambda (index2) 
                                                    (lambda (_) ((lambda (out2) 
                                                                   (let ([j out2])
                                                                   (list '() j))) (mread-char)))) '()))
                                             )) (mread-int))
  )) internal_env)) (array_init_withenv taille_cle (lambda (index) 
                                                     (lambda (_) ((lambda (out0) 
                                                                    (let ([g out0])
                                                                    (list '() g))) (mread-char)))) '()))
)) (mread-int))
)

