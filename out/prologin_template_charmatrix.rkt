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

(define read_int (lambda () 
                   ((lambda (out_) 
                      (block (mread-blank) out_ )) (mread-int))))
(define read_char_line (lambda (n) 
                         (let ([tab (array_init_withenv n (lambda (i) 
                                                            (lambda (n) 
                                                              ((lambda (t_) 
                                                                 (let ([h t_])
                                                                   (list n h))) (mread-char)))) n)])
(block (mread-blank) tab ))))
(define read_char_matrix (lambda (x y) 
                           (let ([tab (array_init_withenv y (lambda (z) 
                                                              (lambda (internal_env) (apply (lambda
                                                               (x y) 
                                                              (let ([g (read_char_line x)])
                                                                (list (list x y) g))) internal_env))) (list x y))])
                           tab)))
(define programme_candidat (lambda (tableau taille_x taille_y) 
                             (let ([out_ 0])
                               (let ([e 0])
                                 (let ([f (- taille_y 1)])
                                   (letrec ([a (lambda (i out_ tableau taille_x taille_y) 
                                                 (if (<= i f)
                                                   (let ([c 0])
                                                     (let ([d (- taille_x 1)])
                                                       (letrec ([b (lambda (j out_ tableau taille_x taille_y) 
                                                                    (if (<= j d)
                                                                    (let ([out_ (+ out_ (* (char->integer (vector-ref (vector-ref tableau i) j)) (+ i (* j 2))))])
                                                                    (block
                                                                    (display (vector-ref (vector-ref tableau i) j))
                                                                    (b (+ j 1) out_ tableau taille_x taille_y)
                                                                    ))
                                                                    (block
                                                                    (display "--\n")
                                                                    (a (+ i 1) out_ tableau taille_x taille_y)
                                                                    )))])
                                                       (b c out_ tableau taille_x taille_y))))
                                                 out_))])
                                 (a e out_ tableau taille_x taille_y)))))))
(define main (let ([taille_x (read_int )])
               (let ([taille_y (read_int )])
                 (let ([tableau (read_char_matrix taille_x taille_y)])
                   (block
                     (display (programme_candidat tableau taille_x taille_y))
                     (display "\n")
                     )))))

