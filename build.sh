#!/bin/bash

#echo -- reflection
#D=draft-ietf-lsr-isis-flood-reflector.v2v3

# xml2rfc $D.xml


  for f in example_plain.svg
  do
    cp $f $f.orig
     rm $f.post


#     xmlstarlet ed -d "//svg:g/@inkscape:label" | xmlstarlet ed -d "//svg:g/@inkscape:groupmode" | \
#     xmlstarlet ed -d "//svg:rect/@style" | \
#     xmlstarlet ed -d "//svg:path/@style" | \
#     xmlstarlet ed -d "//svg:text/@style" | \
#     xmlstarlet ed -d "//svg:text/svg:tspan"  | \

    cat $f | \
    xmlstarlet ed -d "//sodipodi:namedview" | xmlstarlet ed -d "//svg:metadata" | \
    xmlstarlet ed -d "//@inkscape:version" | xmlstarlet ed -d "//@sodipodi:docname" | \
    xmlstarlet ed -d "//svg:text/@stroke" > $f.prepost
    svgcheck -a -r -g $f.prepost > $f.post

    sed -i 's/stroke="none"//g' $f.post
    # rm $f.1
    done

echo '*** if tools on ietf side collapse, there may be a stroke="none" problem on some element and need be removed manually'
echo '*** in expanded xml'

echo -- disttopo
D1=draft-lsr-distopflood
D2=draft-rigatoni-lsr-isis-fragment-timestamping
D3=draft-ietf-lsr-flood-reduction-arch
D4=draft-westphal-lsr-isis-database-checksumming

for D in $D2
do
  xml2rfc --allow-local-file-access --text $D.xml
  xml2rfc --allow-local-file-access --html $D.xml
  xml2rfc --allow-local-file-access --expand $D.xml
  xml2rfc --legacy --allow-local-file-access --text --raw $D.xml
  # echo 'sed\ing stroke none'
  # sed -i 's/stroke="none"//g' $D.exp.xml

  nl -ba $D.txt > $D.nl.txt
done



