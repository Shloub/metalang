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

(define (devine0 nombre tab len)
  ;toto
  (let ([min0 (vector-ref tab 0)])
  (let ([max0 (vector-ref tab 1)])
  (let ([c 2])
  (let ([d (- len 1)])
  (letrec ([b (lambda (i max0 min0) 
                (if (<= i d)
                (if (or (> (vector-ref tab i) max0) (< (vector-ref tab i) min0))
                #f
                (let ([min0 (if (< (vector-ref tab i) nombre)
                            (let ([min0 (vector-ref tab i)])
                            min0)
                            min0)])
                (let ([max0 (if (> (vector-ref tab i) nombre)
                            (let ([max0 (vector-ref tab i)])
                            max0)
                            max0)])
                (if (and (eq? (vector-ref tab i) nombre) (not (eq? len (+ i 1))))
                #f
                (b (+ i 1) max0 min0)))))
                #t))])
  (b c max0 min0))))))
)
(define main
  ((lambda (nombre) 
     (block
       (mread-blank)
       ((lambda (len) 
          (block
            (mread-blank)
            ((lambda (internal_env) (apply (lambda (f tab) 
                                                  (block
                                                    f
                                                    (let ([a (devine0 nombre tab len)])
                                                    (block
                                                      (if a
                                                      (display "True")
                                                      (display "False"))
                                                      '()
                                                      ))
                                                    )) internal_env)) (array_init_withenv len 
            (lambda (i) 
              (lambda (_) ((lambda (tmp) 
                             (block
                               (mread-blank)
                               (let ([e tmp])
                               (list '() e))
                               )) (mread-int)))) '()))
       )) (mread-int))
)) (mread-int))
)

