;; stl-unit-check.lsp - Check drawing units before STL export
;; Command: STLUNIT
(defun c:STLUNIT ( / ins )
  (setq ins (getvar "INSUNITS"))
  (princ (strcat "\nCurrent INSUNITS value: " (itoa ins)))
  (if (= ins 4)
    (princ "\nGood: the drawing is set to millimeters, which is what most slicers expect.")
    (princ "\nWarning: set the drawing to millimeters (INSUNITS = 4) or scale the model before exporting STL.")
  )
  (princ)
)
