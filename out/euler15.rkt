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

(define main (let ([n 10])
               ; normalement on doit mettre 20 mais là on se tape un overflow 
               (let ([n (+ n 1)])
                 (let ([tab (array_init_withenv n (lambda (i) 
                                                    (lambda (n) 
                                                      (let ([tab2 (array_init_withenv n 
                                                        (lambda (j) 
                                                          (lambda (internal_env) (apply (lambda
                                                           (i n) 
                                                          (let ([b 0])
                                                            (list (list i n) b))) internal_env))) (list i n))])
                                                      (let ([a tab2])
                                                        (list n a))))) n)])
  (let ([ba 0])
    (let ([bb (- n 1)])
      (letrec ([z (lambda (l n) 
                    (if (<= l bb)
                      (block
                        (vector-set! (vector-ref tab (- n 1)) l 1)
                        (vector-set! (vector-ref tab l) (- n 1) 1)
                        (z (+ l 1) n)
                        )
                      (let ([x 2])
                        (let ([y n])
                          (letrec ([s (lambda (o n) 
                                        (if (<= o y)
                                          (let ([r (- n o)])
                                            (let ([v 2])
                                              (let ([w n])
                                                (letrec ([u (lambda (p r n) 
                                                              (if (<= p w)
                                                                (let ([q (- n p)])
                                                                  (block
                                                                    (vector-set! (vector-ref tab r) q (+ (vector-ref (vector-ref tab (+ r 1)) q) (vector-ref (vector-ref tab r) (+ q 1))))
                                                                    (u (+ p 1) r n)
                                                                    ))
                                                                (s (+ o 1) n)))])
                                                (u v r n)))))
                                        (let ([g 0])
                                          (let ([h (- n 1)])
                                            (letrec ([c (lambda (m n) 
                                                          (if (<= m h)
                                                            (let ([e 0])
                                                              (let ([f (- n 1)])
                                                                (letrec ([d 
                                                                  (lambda (k n) 
                                                                    (if (<= k f)
                                                                    (block
                                                                    (display (vector-ref (vector-ref tab m) k))
                                                                    (display " ")
                                                                    (d (+ k 1) n)
                                                                    )
                                                                    (block
                                                                    (display "\n")
                                                                    (c (+ m 1) n)
                                                                    )))])
                                                                (d e n))))
                                                          (block
                                                            (display (vector-ref (vector-ref tab 0) 0))
                                                            (display "\n")
                                                            )))])
                                          (c g n))))))])
                    (s x n))))))])
(z ba n))))))))

