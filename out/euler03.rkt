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

(define main (let ([maximum 1])
               (let ([b0 2])
                 (let ([a 408464633])
                   (letrec ([d (lambda (a b0 maximum) 
                                 (if (not (eq? a 1))
                                   (let ([b b0])
                                     (let ([found #f])
                                       (letrec ([g (lambda (found b a b0 maximum) 
                                                     (if (< (* b b) a)
                                                       (let ([h (lambda (found b a b0 maximum) 
                                                                  (let ([b (+ b 1)])
                                                                    (g found b a b0 maximum)))])
                                                       (if (eq? (remainder a b) 0)
                                                         (let ([a (quotient a b)])
                                                           (let ([b0 b])
                                                             (let ([b a])
                                                               (let ([found #t])
                                                                 (h found b a b0 maximum)))))
                                                         (h found b a b0 maximum)))
                                                     (let ([e (lambda (found b a b0 maximum) 
                                                                (d a b0 maximum))])
                                                     (if (not found)
                                                       (block
                                                         (display a)
                                                         (display "\n")
                                                         (let ([a 1])
                                                           (e found b a b0 maximum))
                                                         )
                                                       (e found b a b0 maximum)))))])
                                   (g found b a b0 maximum))))
                   '()))])
  (d a b0 maximum))))))

