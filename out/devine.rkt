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

(define (devine_ nombre tab len)
  ;toto
  (let ([min_ (vector-ref tab 0)])
  (let ([max_ (vector-ref tab 1)])
  (let ([c 2])
  (let ([d (- len 1)])
  (letrec ([b (lambda (i max_ min_) 
                (if (<= i d)
                (if (or (> (vector-ref tab i) max_) (< (vector-ref tab i) min_))
                #f
                (let ([min_ (if (< (vector-ref tab i) nombre)
                            (let ([min_ (vector-ref tab i)])
                            min_)
                            min_)])
                (let ([max_ (if (> (vector-ref tab i) nombre)
                            (let ([max_ (vector-ref tab i)])
                            max_)
                            max_)])
                (if (and (eq? (vector-ref tab i) nombre) (not (eq? len (+ i 1))))
                #f
                (b (+ i 1) max_ min_)))))
                #t))])
  (b c max_ min_))))))
)
(define main
  ((lambda (nombre) 
     (block (mread-blank) ((lambda (len) 
                             (block (mread-blank) (let ([tab (array_init_withenv len 
                                                  (lambda (i) 
                                                    (lambda (_) ((lambda (tmp) 
                                                                   (block (mread-blank) 
                                                                   (let ([e tmp])
                                                                   (list '() e)) )) (mread-int)))) '())])
     (let ([a (devine_ nombre tab len)])
     (block
       (if a
       (display "True")
       (display "False"))
       '()
       ))) )) (mread-int)) )) (mread-int))
)

