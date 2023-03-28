#!/bin/sh

for ANNOTATOR_DIR in $(find . -maxdepth 1 -mindepth 1 -type d); do
  ANNOTATOR=$(basename $ANNOTATOR_DIR)
  echo $ANNOTATOR
  mkdir -p $ANNOTATOR-coref
  mkdir -p $ANNOTATOR-quotes
  # convert the corpus files (CoNLL -> CSV, concatenate to one per annotator)
  flopo-convert -f conll -t csv -i $ANNOTATOR/conll -o $ANNOTATOR/$ANNOTATOR-corpus.csv
  sed -i "s:^$ANNOTATOR/conll/::; s:\.conllu::" $ANNOTATOR/$ANNOTATOR-corpus.csv
  # convert the annotations
  # This may throw exceptions: "Annotation layer not found", which is harmless
  # (indeed not all articles contain the desired annotations).
  for FILENAME in $(find $ANNOTATOR_DIR/annotation -type f); do
    DOCID=$(basename $(dirname $FILENAME) | sed 's:\.\(txt\|conllu\)::')
    echo $ANNOTATOR $FILENAME $DOCID
    # coreferences
    flopo-export -i $FILENAME -a CoreferenceLink --doc-id $DOCID > $ANNOTATOR-coref/$DOCID.csv
    # quotes
    flopo-export -i $FILENAME -a Quote --doc-id $DOCID > $ANNOTATOR-quotes/$DOCID.csv
  done
  # concatenate the annotation files (one per article -> one per annotator)
  find $ANNOTATOR-coref -empty -delete
  csvstack $ANNOTATOR-coref/*.csv > $ANNOTATOR/$ANNOTATOR-coref.csv
  rm -rf $ANNOTATOR-coref
  find $ANNOTATOR-quotes -empty -delete
  csvstack $ANNOTATOR-quotes/*.csv > $ANNOTATOR/$ANNOTATOR-quotes.csv
  rm -rf $ANNOTATOR-quotes
done
