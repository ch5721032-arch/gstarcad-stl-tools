;; stl-batch.lsp - Export each selected solid to its own STL file
;; Command: STLBATCH
;; Usage: pick an output folder, then select the 3D solids
(defun c:STLBATCH ( / folder ss i en f )
  (setq folder (getstring T "\nOutput folder (e.g. C:/STL): "))
  (if (= folder "") (setq folder "C:/STL"))
  (setq ss (ssget '((0 . "3DSOLID"))))
  (if ss
    (progn
      (setvar "FILEDIA" 0)
      (setq i 0)
      (repeat (sslength ss)
        (setq en (ssname ss i)
              f (strcat folder "/part-" (itoa (1+ i)) ".stl"))
        (command "_.STLOUT" en "_Y" f)
        (princ (strcat "\nExported " f))
        (setq i (1+ i))
      )
      (setvar "FILEDIA" 1)
      (princ (strcat "\n" (itoa (sslength ss)) " solids exported."))
    )
    (princ "\nNo 3D solids selected.")
  )
  (princ)
)
