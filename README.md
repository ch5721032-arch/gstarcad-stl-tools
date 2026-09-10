# GstarCAD STL Export Tools

Batch STL export for 3D solids plus a unit check for clean 3D printing workflows.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

3D printing a design starts with a clean STL export. These helpers export each selected 3D solid to its own STL file named part-1, part-2 and so on, and check the drawing units first, because most slicers expect millimetres.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/stl-batch.lsp` | ;; stl-batch.lsp - Export each selected solid to its own STL file
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
 |
| `scripts/stl-unit-check.lsp` | ;; stl-unit-check.lsp - Check drawing units before STL export
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
