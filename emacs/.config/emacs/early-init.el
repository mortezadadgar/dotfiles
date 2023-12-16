;; annoyance suppression
(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)

;; Increase gc threshold
(setq gc-cons-threshold (* 10 1024 1024))
