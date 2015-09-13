#lang racket

(require racket/port)
(require racket/string)
(require scheme/system)


;;
;; TODO
;;
;; other shells
;; other flags? Like `lah -2 what` to lah the second to last command?
;; no more `#t` returns in terminal
;; help/error messages
;;



(define INFILE "~/.config/fish/fish_history")


(define (match-one-part regexp string)
  (let ((match (regexp-match regexp string)))
    (cond
      ((list? match)
       (car (cdr match)))
      (else #f))))



(define (get-cmd line)
  (match-one-part #px"^- cmd: (.+)$" line))

(define (get-exec-name command)
  (match-one-part #px"^([^ ]+)" command))



(define (get-last-command file)

  (define (line-iter file last-cmd)
    (let ((line (read-line file)))
        (cond
          ((eof-object? line) last-cmd)
          (else
           (let ((cmd-check (get-cmd line)))
             (cond
               ((and (string? cmd-check)
                     (not (equal? (get-exec-name cmd-check) "lah")))
                (line-iter file cmd-check))
               (else
                (line-iter file last-cmd))))))))

  (line-iter file #f))



(define (help-message)
  "A helpful message will be returned from here")

(define (fail-message)
  "A failful message will be returned from here")



(define (replace-last-command new-command)
  (let ((old-command (call-with-input-file (expand-user-path INFILE)
                       get-last-command)))
    (string-replace old-command
                    (get-exec-name old-command)
                    new-command)))


(define (join list joiner)

  (define (join-iter list joiner string)
    (cond
      ((null? list) string)
      (else
       (join-iter (cdr list)
                  joiner
                  (string-append string
                                 (car list)
                                 joiner)))))

  (string-trim (join-iter list joiner "") joiner))



(define (build-new-command args)
  (string-append (string-trim (replace-last-command (car args)))
                 " "
                 (join (cdr args) " ")))



(define (main args)
  (let ((new-command (build-new-command args)))
    (cond
      ((string? new-command)
       (system new-command))
      (else
       (displayln (fail-message))))))

;; (main '("hi"))


(define (parse-args)
  (cond
    ((< 0 (vector-length (current-command-line-arguments)))
     (main (vector->list (current-command-line-arguments))))
    (else
     (displayln (help-message)))))

(parse-args)
