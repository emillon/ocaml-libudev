# Makefile used for development

OB=ocamlbuild -tag debug -classic-display -use-ocamlfind 
ODOCFLAGS=-docflags -colorize-code,-charset,utf8

lib:
	$(OB) libudev.cma libudev.cmxa

examples: lib
	$(OB) examples.otarget

plugin:
	$(OB) -tag use_ocamldoc -package compiler-libs doc/plugin.cmx
	ocamlopt -o _build/doc/plugin.cmxs -shared _build/doc/plugin.cmx

doc: lib plugin
	$(OB) $(ODOCFLAGS) doc/api.docdir/index.html
	cp doc/style.css _build/doc/api.docdir/style.css

upload_doc: doc
	git checkout gh-pages && rm -rf dev/* && cp api.docdir/* dev && \
	git add --all dev

clean:
	$(OB) -clean
