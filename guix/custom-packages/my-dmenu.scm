(define-module (my-dmenu)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages xorg)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages))

(define-public my-dmenu
  (package
    (name "my-dmenu")
    (version "5.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
          (url "https://gitlab.com/tkiatd/suckless-dmenu")
          (commit "cca519ac6701681d6e721e0388a99849f50a2cda")))
        (sha256
          (base32 "1r6w8wnlfgmv09bay014s5fcvliky805xy7b3mxvabr41mpgg21m"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f                      ; no tests
       #:make-flags
       (list (string-append "CC=gcc")
             (string-append "PREFIX=" %output)
             (string-append "FREETYPEINC="
                            (assoc-ref %build-inputs "freetype")
                            "/include/freetype2"))
       #:phases
       (modify-phases %standard-phases (delete 'configure))))
    (inputs
     `(("libx11" ,libx11)
       ("libxft" ,libxft)
       ("libxinerama" ,libxinerama)
       ("freetype" ,freetype)))
    (native-inputs
     `(("pkg-config" ,pkg-config)))
    (home-page "https://gitlab.com/tkiatd/suckless-dmenu")
    (synopsis "tkiatd version of dmenu: dynamic menu")
    (description
     "A dynamic menu for X, originally designed for dwm.  It manages large
numbers of user-defined menu items efficiently.")
    (license license:x11)))
