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

(define (read_int _)
  ;toto
  ((lambda (out_) 
     (block (mread-blank) out_ )) (mread-int))
)
(define (read_char_line n)
  ;toto
  (let ([tab (array_init_withenv n (lambda (i) 
                                     (lambda (_) ((lambda (t_) 
                                                    (let ([d t_])
                                                    (list '() d))) (mread-char)))) '())])
(block (mread-blank) tab ))
)
(define (programme_candidat tableau taille)
  ;toto
  (let ([out_ 0])
  (let ([b 0])
  (let ([c (- taille 1)])
  (letrec ([a (lambda (i out_) 
                (if (<= i c)
                (let ([out_ (+ out_ (* (char->integer (vector-ref tableau i)) i))])
                (block
                  (display (vector-ref tableau i))
                  (a (+ i 1) out_)
                  ))
                (block
                  (display "--\n")
                  out_
                  )))])
  (a b out_)))))
)
(define main
  (let ([taille (read_int 'nil)])
  (let ([tableau (read_char_line taille)])
  (block
    (display (programme_candidat tableau taille))
    (display "\n")
    )))
)

