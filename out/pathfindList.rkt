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

(define pathfind_aux (lambda (cache tab len pos) 
                       (let ([b (lambda (cache tab len pos) 
                                  '())])
                       (if (>= pos (- len 1))
                         0
                         (let ([c (lambda (cache tab len pos) 
                                    (b cache tab len pos))])
                         (if (not (eq? (vector-ref cache pos) (- 1)))
                           (vector-ref cache pos)
                           (block (vector-set! cache pos (* len 2)) (let ([posval (pathfind_aux cache tab len (vector-ref tab pos))])
                                                                    (let ([oneval (pathfind_aux cache tab len (+ pos 1))])
                                                                    (let ([out_ 0])
                                                                    (let ([d 
                                                                    (lambda (out_ oneval posval cache tab len pos) 
                                                                    (block (vector-set! cache pos out_) out_))])
                                                                    (if (< posval oneval)
                                                                    (let ([out_ (+ 1 posval)])
                                                                    (d out_ oneval posval cache tab len pos))
                                                                    (let ([out_ (+ 1 oneval)])
                                                                    (d out_ oneval posval cache tab len pos))))))))))))))
(define pathfind (lambda (tab len) 
                   (let ([cache (array_init_withenv len (lambda (i) 
                                                          (lambda (internal_env) (apply (lambda
                                                           (tab len) 
                                                          (let ([a (- 1)])
                                                            (list (list tab len) a))) internal_env))) (list tab len))])
                   (pathfind_aux cache tab len 0))))
(define main (let ([len 0])
               ((lambda (g) 
                  (let ([len g])
                    (block (mread-blank) (let ([tab (array_init_withenv len 
                                           (lambda (i) 
                                             (lambda (len) 
                                               (let ([tmp 0])
                                                 ((lambda (f) 
                                                    (let ([tmp f])
                                                      (block (mread-blank) 
                                                      (let ([e tmp])
                                                        (list len e)) ))) (mread-int))))) len)])
               (let ([result (pathfind tab len)])
                 (display result))) ))) (mread-int))))

