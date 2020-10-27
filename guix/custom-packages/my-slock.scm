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
                    (commit "739a505848c8da29dae56f74ec279e0841268668")))
              (sha256
               (base32
                "0iwk2vmq8kl64lzra6zgaxrwc8rrlmqjyzg4h29zb4pgxkb57akv"))))
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
