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

(define min2 (lambda (a b) 
               (let ([m (lambda (a b) 
                          '())])
               (if (< a b)
                 a
                 b))))
(define min3 (lambda (a b c) 
               (min2 (min2 a b) c)))
(define min4 (lambda (a b c d) 
               (min3 (min2 a b) c d)))
(define pathfind_aux (lambda (cache tab x y posX posY) 
                       (let ([g (lambda (cache tab x y posX posY) 
                                  '())])
                       (if (and (eq? posX (- x 1)) (eq? posY (- y 1)))
                         0
                         (let ([h (lambda (cache tab x y posX posY) 
                                    (g cache tab x y posX posY))])
                         (if (or (or (or (< posX 0) (< posY 0)) (>= posX x)) (>= posY y))
                           (* (* x y) 10)
                           (let ([k (lambda (cache tab x y posX posY) 
                                      (h cache tab x y posX posY))])
                           (if (eq? (vector-ref (vector-ref tab posY) posX) (integer->char 35))
                             (* (* x y) 10)
                             (let ([l (lambda (cache tab x y posX posY) 
                                        (k cache tab x y posX posY))])
                             (if (not (eq? (vector-ref (vector-ref cache posY) posX) (- 1)))
                               (vector-ref (vector-ref cache posY) posX)
                               (block
                                 (vector-set! (vector-ref cache posY) posX (* (* x y) 10))
                                 (let ([val1 (pathfind_aux cache tab x y (+ posX 1) posY)])
                                   (let ([val2 (pathfind_aux cache tab x y (- posX 1) posY)])
                                     (let ([val3 (pathfind_aux cache tab x y posX (- posY 1))])
                                       (let ([val4 (pathfind_aux cache tab x y posX (+ posY 1))])
                                         (let ([out_ (+ 1 (min4 val1 val2 val3 val4))])
                                           (block
                                             (vector-set! (vector-ref cache posY) posX out_)
                                             out_
                                             ))))))
                                 )))))))))))
(define pathfind (lambda (tab x y) 
                   (let ([cache (array_init_withenv y (lambda (i) 
                                                        (lambda (internal_env) (apply (lambda
                                                         (tab x y) 
                                                        (let ([tmp (array_init_withenv x 
                                                          (lambda (j) 
                                                            (lambda (internal_env) (apply (lambda
                                                             (i tab x y) 
                                                            (let ([f (- 1)])
                                                              (list (list i tab x y) f))) internal_env))) (list i tab x y))])
                                                        (let ([e tmp])
                                                          (list (list tab x y) e)))) internal_env))) (list tab x y))])
  (pathfind_aux cache tab x y 0 0))))
(define main (let ([x 0])
               (let ([y 0])
                 ((lambda (r) 
                    (let ([x r])
                      (block (mread-blank) ((lambda (q) 
                                              (let ([y q])
                                                (block (mread-blank) 
                                                (let ([tab (array_init_withenv y 
                                                  (lambda (i) 
                                                    (lambda (internal_env) (apply (lambda
                                                     (y x) 
                                                    (let ([tab2 (array_init_withenv x 
                                                      (lambda (j) 
                                                        (lambda (internal_env) (apply (lambda
                                                         (i y x) 
                                                        (let ([tmp (integer->char 0)])
                                                          ((lambda (p) 
                                                             (let ([tmp p])
                                                               (let ([o tmp])
                                                                 (list (list i y x) o)))) (mread-char)))) internal_env))) (list i y x))])
                                                    (block (mread-blank) 
                                                    (let ([n tab2])
                                                      (list (list y x) n)) ))) internal_env))) (list y x))])
                      (let ([result (pathfind tab x y)])
                        (display result))) ))) (mread-int)) ))) (mread-int)))))

