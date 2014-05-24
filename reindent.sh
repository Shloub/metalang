#!/bin/bash

#
# Ce fichier lance emacs pour tout réindenter.
# Il faut avoir ça dans son .emacs
#
#(defun emacs-indent-function ()
#   "Format the whole buffer."
#   (indent-region (point-min) (point-max) nil)
#   (untabify (point-min) (point-max))
#   (delete-trailing-whitespace)
#    (save-buffer)
# )
#
# NOTE : Faire un make clean avant, sinon, les fichiers générés par ocamllex et ocamlyacc vont prendre un temps de dingue à être réindentés.
#
#

for i in `find . -name '*.ml'`; do
    echo $i
    emacs "$i" -f emacs-indent-function
done
