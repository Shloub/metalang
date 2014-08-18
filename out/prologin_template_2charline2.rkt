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

(define read_int (lambda (_) 
                   ((lambda (out_) 
                      (block (mread-blank) out_ )) (mread-int))))
(define read_char_line (lambda (n) 
                         (let ([tab (array_init_withenv n (lambda (i) 
                                                            (lambda (_) (
                                                            (lambda (t_) 
                                                              (let ([g t_])
                                                                (list '() g))) (mread-char)))) '())])
  (block (mread-blank) tab ))))
(define programme_candidat (lambda (tableau1 taille1 tableau2 taille2) 
                             (let ([out_ 0])
                               (let ([e 0])
                                 (let ([f (- taille1 1)])
                                   (letrec ([d (lambda (i out_) 
                                                 (if (<= i f)
                                                   (let ([out_ (+ out_ (* (char->integer (vector-ref tableau1 i)) i))])
                                                     (block
                                                       (display (vector-ref tableau1 i))
                                                       (d (+ i 1) out_)
                                                       ))
                                                   (block
                                                     (display "--\n")
                                                     (let ([b 0])
                                                       (let ([c (- taille2 1)])
                                                         (letrec ([a 
                                                           (lambda (j out_) 
                                                             (if (<= j c)
                                                               (let ([out_ (+ out_ (* (char->integer (vector-ref tableau2 j)) (* j 100)))])
                                                                 (block
                                                                   (display (vector-ref tableau2 j))
                                                                   (a (+ j 1) out_)
                                                                   ))
                                                               (block
                                                                 (display "--\n")
                                                                 out_
                                                                 )))])
                                                         (a b out_))))
                                                   )))])
                                 (d e out_)))))))
(define main (let ([taille1 (read_int 'nil)])
               (let ([taille2 (read_int 'nil)])
                 (let ([tableau1 (read_char_line taille1)])
                   (let ([tableau2 (read_char_line taille2)])
                     (block
                       (display (programme_candidat tableau1 taille1 tableau2 taille2))
                       (display "\n")
                       ))))))

