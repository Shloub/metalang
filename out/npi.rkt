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

(define is_number (lambda (c) 
                    (and (<= (char->integer c) (char->integer #\9)) (>= (char->integer c) (char->integer #\0)))))
(define npi_ (lambda (str len) 
               (let ([stack (array_init_withenv len (lambda (i) 
                                                      (lambda (internal_env) (apply (lambda
                                                       (str len) 
                                                      (let ([a 0])
                                                        (list (list str len) a))) internal_env))) (list str len))])
               (let ([ptrStack 0])
                 (let ([ptrStr 0])
                   (letrec ([d (lambda (ptrStr ptrStack str len) 
                                 (if (< ptrStr len)
                                   (let ([e (lambda (ptrStr ptrStack str len) 
                                              (d ptrStr ptrStack str len))])
                                   (if (eq? (vector-ref str ptrStr) #\Space)
                                     (let ([ptrStr (+ ptrStr 1)])
                                       (e ptrStr ptrStack str len))
                                     (let ([f (lambda (ptrStr ptrStack str len) 
                                                (e ptrStr ptrStack str len))])
                                     (if (is_number (vector-ref str ptrStr))
                                       (let ([num 0])
                                         (letrec ([h (lambda (num ptrStr ptrStack str len) 
                                                       (if (not (eq? (vector-ref str ptrStr) #\Space))
                                                         (let ([num (- (+ (* num 10) (char->integer (vector-ref str ptrStr))) (char->integer #\0))])
                                                           (let ([ptrStr (+ ptrStr 1)])
                                                             (h num ptrStr ptrStack str len)))
                                                         (block
                                                           (vector-set! stack ptrStack num)
                                                           (let ([ptrStack (+ ptrStack 1)])
                                                             (f ptrStr ptrStack str len))
                                                           )))])
                                         (h num ptrStr ptrStack str len)))
                                     (let ([j (lambda (ptrStr ptrStack str len) 
                                                (f ptrStr ptrStack str len))])
                                     (if (eq? (vector-ref str ptrStr) (integer->char 43))
                                       (block
                                         (vector-set! stack (- ptrStack 2) (+ (vector-ref stack (- ptrStack 2)) (vector-ref stack (- ptrStack 1))))
                                         (let ([ptrStack (- ptrStack 1)])
                                           (let ([ptrStr (+ ptrStr 1)])
                                             (j ptrStr ptrStack str len)))
                                         )
                                       (j ptrStr ptrStack str len)))))))
                 (vector-ref stack 0)))])
(d ptrStr ptrStack str len)))))))
(define main (let ([len 0])
               ((lambda (m) 
                  (let ([len m])
                    (block (mread-blank) (let ([tab (array_init_withenv len 
                                           (lambda (i) 
                                             (lambda (len) 
                                               (let ([tmp (integer->char 0)])
                                                 ((lambda (l) 
                                                    (let ([tmp l])
                                                      (let ([k tmp])
                                                        (list len k)))) (mread-char))))) len)])
               (let ([result (npi_ tab len)])
                 (display result))) ))) (mread-int))))
