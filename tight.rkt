#lang racket

(require racket/base
         racket/path
         racket/file)

(define verbosity 0)
(define (msg level fmt . vs)
  (when (>= verbosity level)
    (apply printf fmt vs)
    (newline)))
(define (mkdir path)
  (with-handlers ([exn:fail? (const (void))])
    (define-values (base name dir?)(split-path path))
    (make-directory* base)))

(module+ main
  (command-line
   #:program "tight"
   #:once-each
   [("--version") ("Initialize new Tight project") (tight-version)]
   [("--init") ("Initialize new Tight project") (tight-init)]
   #:args all (build)))

(define (tight-version)
  (printf "Tight ~a\n" version))

(define (build)
  (msg 0 "What did you expect!"))

(define (tight-init)
  (define (copy path)
    (define from (simplify-path (build-path "template" path)))
    (define to   (simplify-path (build-path (current-directory) path)))
    (msg 0 "copying: ~a" to) (mkdir to) (copy-directory/files from to))
  (copy "index.html")
  (msg 0 "Done"))
