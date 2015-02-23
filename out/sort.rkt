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

(define (copytab tab len)
  ;toto
  ((lambda (internal_env) (apply (lambda (k o) 
                                        (block
                                          k
                                          o
                                          )) internal_env)) (array_init_withenv len 
  (lambda (i) 
    (lambda (_) (let ([h (vector-ref tab i)])
                (list '() h)))) '()))
)
(define (bubblesort tab len)
  ;toto
  (let ([f 0])
  (let ([g (- len 1)])
  (letrec ([b (lambda (i) 
                (if (<= i g)
                (let ([d (+ i 1)])
                (let ([e (- len 1)])
                (letrec ([c (lambda (j) 
                              (if (<= j e)
                              (block
                                (if (> (vector-ref tab i) (vector-ref tab j))
                                (let ([tmp (vector-ref tab i)])
                                (block
                                  (vector-set! tab i (vector-ref tab j))
                                  (vector-set! tab j tmp)
                                  ))
                                '())
                                (c (+ j 1))
                                )
                              (b (+ i 1))))])
                (c d))))
                '()))])
  (b f))))
)
(define (qsort0 tab len i j)
  ;toto
  ((lambda (internal_env) (apply (lambda (i j) 
                                        '()) internal_env)) (if (< i j)
                                                            (let ([i0 i])
                                                            (let ([j0 j])
                                                            ; pivot : tab[0] 
                                                            (letrec ([a (lambda (i j) 
                                                                          (if (not (eq? i j))
                                                                          ((lambda (internal_env) (apply (lambda
                                                                           (i j) 
                                                                          (a i j)) internal_env)) 
                                                                          (if (> (vector-ref tab i) (vector-ref tab j))
                                                                          (let ([i 
                                                                          (if (eq? i (- j 1))
                                                                          ; on inverse simplement
                                                                          (let ([tmp (vector-ref tab i)])
                                                                          (block
                                                                            (vector-set! tab i (vector-ref tab j))
                                                                            (vector-set! tab j tmp)
                                                                            (let ([i (+ i 1)])
                                                                            i)
                                                                            ))
                                                                          ; on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] 
                                                                          (let ([tmp (vector-ref tab i)])
                                                                          (block
                                                                            (vector-set! tab i (vector-ref tab j))
                                                                            (vector-set! tab j (vector-ref tab (+ i 1)))
                                                                            (vector-set! tab (+ i 1) tmp)
                                                                            (let ([i (+ i 1)])
                                                                            i)
                                                                            )))])
                                                                          (list i j))
                                                                          (let ([j (- j 1)])
                                                                          (list i j))))
                                                                          (block
                                                                            (qsort0 tab len i0 (- i 1))
                                                                            (qsort0 tab len (+ i 1) j0)
                                                                            (list i j)
                                                                            )))])
                                                            (a i j))))
  (list i j)))
)
(define main
  (let ([len 2])
  ((lambda (w) 
     (let ([len w])
     (block
       (mread-blank)
       ((lambda (internal_env) (apply (lambda (m tab) 
                                             (block
                                               m
                                               (let ([tab2 (copytab tab len)])
                                               (block
                                                 (bubblesort tab2 len)
                                                 (let ([u 0])
                                                 (let ([v (- len 1)])
                                                 (letrec ([s (lambda (i) 
                                                               (if (<= i v)
                                                               (block
                                                                 (map display (list (vector-ref tab2 i) " "))
                                                                 (s (+ i 1))
                                                                 )
                                                               (block
                                                                 (display "\n")
                                                                 (let ([tab3 (copytab tab len)])
                                                                 (block
                                                                   (qsort0 tab3 len 0 (- len 1))
                                                                   (let ([q 0])
                                                                   (let ([r (- len 1)])
                                                                   (letrec ([p (lambda (i) 
                                                                                (if (<= i r)
                                                                                (block
                                                                                (map display (list (vector-ref tab3 i) " "))
                                                                                (p (+ i 1))
                                                                                )
                                                                                (display "\n")))])
                                                                   (p q))))
                                                                 ))
                                                               )))])
                                                 (s u))))
                                               ))
       )) internal_env)) (array_init_withenv len (lambda (i_) 
                                                   (lambda (_) (let ([tmp 0])
                                                               ((lambda (n) 
                                                                  (let ([tmp n])
                                                                  (block
                                                                    (mread-blank)
                                                                    (let ([l tmp])
                                                                    (list '() l))
                                                                    ))) (mread-int))))) '()))
  ))) (mread-int)))
)

