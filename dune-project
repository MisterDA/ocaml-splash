(lang dune 3.0)

(name splash)

(generate_opam_files true)

(source
 (github MisterDA/ocaml-splash))

(authors "Antonin Décimo <antonin@tarides.com>")

(maintainers "Antonin Décimo <antonin@tarides.com>")

(license MIT)

(package
 (name splash)
 (synopsis "An OCaml splash screen")
 (description "Did you know 3 Billion Devices Run OCaml?")
 (depends ocaml dune graphics))
