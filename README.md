# Quote and coreference corpus of Finnish news

This repository contains a corpus of quote and coreference annotations
annotated in publicly available Finnish news media articles.

The directories `a01-a10` contain data produced by each of the 10 annotators.
Each directory contains:
* the source texts in CoNLL format,
* the annotated files in WebAnno-TSV format,
* the text and annotations converted to a single CSV file per annotator using the attached conversion script.

Note that the repository uses Git LFS to manage the data files.

The conversion script `convert.sh` requires
[flopo-formats](https://github.com/hsci-r/flopo-formats).

The dataset is described in the following upcoming publication:

Maciej Janicki, Antti Kanner and Eetu Mäkelä.
[Detection and attribution of quotes in Finnish news media: BERT vs. rule-based approach](https://openreview.net/forum?id=YTVwaoG0Mi).
In: *Proceedings of the 24th Nordic Conference on Computational Linguistics (NoDaLiDa)*,
Tórshavn, Faroe Islands, May 2023.
