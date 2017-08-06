(define *vector-size* 30000)

(define-syntax incf
  (syntax-rules ()
    ((_ x)   (begin (set! x (+ x 1)) x))
    ((_ x n) (begin (set! x (+ x n)) x))))

(define-syntax decf
  (syntax-rules ()
    ((_ x)   (begin (set! x (- x 1)) x))
    ((_ x n) (begin (set! x (- x n)) x))))

(define (main args)
  (let*
    ((state (make-vector *vector-size* 0))
     (index 0)
     (char-tmp 0)
     (fd 0)
     (fd (open-input-file (cadr args))))
    (display (read fd))
    ; (while
    ;   (and (set! char-tmp (read-char fd)) (not (eof-object? char-tmp)))
    ;   (map
    ;     ((char=? char-tmp #\>) (incf  index)); (shift-left index))
    ;     ((char=? char-tmp #\<) (decf  index)); (shift-right index))
    ;     ((char=? char-tmp #\+) (plus  state index))
    ;     ((char=? char-tmp #\-) (minus state index))
    ;     ((char=? char-tmp #\.) (dot   state index))
    ;     ((char=? char-tmp #\,) (comma state index))
    ;     ((char=? char-tmp #\[) (bracket-left  state index))
    ;     ((char=? char-tmp #\]) (bracket-right state index))))
    (close-input-port fd)))

(define (shift-left index)
  (if (< index (- 1 *vector-size*))
    (incf index)))

(define (shift-right index)
  (if (>= index 1)
    (decf index)))

(define (plus state index)
  (vector-set!
    state
    index
    (+ 1 (vector-ref state index))))

(define (minus state index)
  (vector-set!
    state
    index
    (- 1 (vector-ref state index))))

(define (dot state index)
  (display (vector-ref state index))
  (newline))

