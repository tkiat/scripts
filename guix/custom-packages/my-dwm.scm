(define-module (my-dwm)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages xorg)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages))

(define-public my-dwm
  (package
    (name "my-dwm")
    (version "6.2")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
          (url "https://gitlab.com/tkiatd/suckless-dwm")
          (commit "4e2e9225aaa1f298d6e0f81e442b6d1364c27993")))
        (sha256
          (base32 "0y9ydy5jai6y3aihs7g65dsl36bphm81cnfv667ckr13nhy7pr8n"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f                      ; no tests
       #:make-flags (list (string-append "FREETYPEINC="
                                         (assoc-ref %build-inputs "freetype")
                                         "/include/freetype2"))
       #:phases
       (modify-phases %standard-phases
         (replace 'configure
           (lambda _
             (substitute* "Makefile" (("\\$\\{CC\\}") "gcc"))
             #t))
        (replace 'install
          (lambda* (#:key outputs #:allow-other-keys)
            (let ((out (assoc-ref outputs "out")))
              (invoke "make" "install"
                      (string-append "DESTDIR=" out) "PREFIX="))))
        (add-after 'build 'install-xsession
          (lambda* (#:key outputs #:allow-other-keys)
            ;; Add a .desktop file to xsessions.
            (let* ((output (assoc-ref outputs "out"))
                   (xsessions (string-append output "/share/xsessions")))
              (mkdir-p xsessions)
              (with-output-to-file
                  (string-append xsessions "/dwm.desktop")
                (lambda _
                  (format #t
                    "[Desktop Entry]~@
                     Name=dwm~@
                     Comment=Dynamic Window Manager~@
                     Exec=~a/bin/dwm~@
                     TryExec=~@*~a/bin/dwm~@
                     Icon=~@
                     Type=Application~%"
                    output)))
              #t))))))
    (inputs
     `(("freetype" ,freetype)
       ("libx11" ,libx11)
       ("libxft" ,libxft)
       ("libxinerama" ,libxinerama)))
    (home-page "https://gitlab.com/tkiatd/suckless-dwm")
    (synopsis "tkiatd version of dwm")
    (description
     "dwm is a dynamic window manager for X.  It manages windows in tiled,
monocle and floating layouts.  All of the layouts can be applied dynamically,
optimising the environment for the application in use and the task performed.")
    (license license:x11)))
