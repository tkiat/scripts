(define-module (my-st)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages xorg)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages))

(define-public my-st
  (package
    (name "my-st")
    (version "0.8.4")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
          (url "https://gitlab.com/tkiatd/suckless-st")
          (commit "47066fe464b57a01186880fc8da0c4b46a9780d6")))
        (sha256
          (base32 "0bflxn8hpjr9mhq3xg5a8hab26i67nlvzw24b49g388fmq2gxgff"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f                      ; no tests
       #:make-flags
       (list (string-append "CC=gcc")
             (string-append "PREFIX=" %output))
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (add-after 'unpack 'inhibit-terminfo-install
           (lambda _
             (substitute* "Makefile"
               (("\ttic .*") ""))
             #t)))))
    (inputs
     `(("libx11" ,libx11)
       ("libxft" ,libxft)
       ("fontconfig" ,fontconfig)
       ("freetype" ,freetype)))
    (native-inputs
     `(("pkg-config" ,pkg-config)))
    (home-page "https://gitlab.com/tkiatd/suckless-st")
    (synopsis "tkiatd version of st: Simple terminal emulator")
    (description
     "St implements a simple and lightweight terminal emulator.  It
implements 256 colors, most VT10X escape sequences, utf8, X11 copy/paste,
antialiased fonts (using fontconfig), fallback fonts, resizing, and line
drawing.")
    (license license:x11)))
