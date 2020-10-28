(define-module (my-slock)
  #:use-module (gnu packages xorg)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module (guix licenses)
  #:use-module (guix packages))

(define-public my-slock
  (package
    (name "my-slock")
    (version "1.4")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://gitlab.com/tkiatd/suckless-slock.git")
                    (commit "07a907f67c2b5c5c7165fcb1ddfc174d1fa72e54")))
              (sha256
               (base32
                "1975lw2hjdikzz0jp8ajzi0aa952dk3jc4vpv262yf6hljx71izh"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f                      ; no tests
       #:make-flags
       (list (string-append "CC=gcc")
             (string-append "PREFIX=" %output))
       #:phases (modify-phases %standard-phases (delete 'configure))))
    (inputs
     `(("libx11" ,libx11)
       ("libxext" ,libxext)
       ("libxinerama" ,libxinerama)
       ("libxrandr" ,libxrandr)))
    (home-page "https://gitlab.com/tkiatd/suckless-slock")
    (synopsis "tkiatd version of Simple X session lock")
    (description
     "This is my version of slock: Simple X session lock with trivial feedback on password entry.")
    (license x11)))
