# phoneng README

## Overview

This phoneng program suite (short for: Phonetic English) shows how English
is pronounced and offers an alternative spelling system that is more
consistent and easier to learn and use than the traditional spelling.

TODO These programs aren't implemented yet.
The `pronounce` command shows how English texts are pronounced. The
`lytspel` command converts them into a simplified spelling.

The provided tools can also be used to implement your own spelling reform
proposals or to adapt the chosen respellings as needed.

## Installation

The phoneng program suite is written in
[Haskell](https://www.haskell.org/haskellwiki/Haskell). To build it from
source, you need the [Cabal](https://www.haskell.org/cabal/) build system.
If you use a Debian-based system, install the `cabal-install` package to
get it.

Afterwards clone this repository from GitHub and run the following commands
in the main directory:

    cabal configure && cabal build && cabal install

The compiled programs should now be in your path and ready to run.

## Usage

TODO document

## Defining own respelling schemes

TODO document

## Files and File Formats

All files are in UTF-8 format (some of them may use just the ASCII subset).

*Line files* (extension: .txt) have one entry per line; line breaks in entries
are therefore not allowed.

*Key-value files* (extension: .txt) are line files where each line represents
a key/value pair. Keys and values are separated by ':'; trailing comments
introduced by '#' are stripped. No escape syntax is supported, hence keys
cannot contain ':', values cannot contain '#', and neither can contain line
breaks.

### Files in data Directory

TODO Update this section.

  * `cmudict-phonemes.txt`: key-value file containing a mapping from the
    phonemes used in cmudict to the corresponding Phonetic English phonemes.
    Used by the `dictbuilder` program.
  * `moby-phonemes.txt`: key-value file containing a mapping from the phonemes
    used in Moby to the corresponding Phonetic English phonemes. Used by the
    `dictbuilder` program.
  * `words-not-in-scowl.txt`: Line file containing words that aren't listed in
    SCOWL but should become part of the pronunciation dictionary. Used by the
    `dictbuilder` program.
  * `phonetic-dict.txt`: Line file containing a mapping from words to their
    pronunciations. If there is just a single pronunciations, the entry is
    written as `word: pron`. If the pronunciation of a word depends on which
    POS (part-of-speed) it is, it is written as `word/n: pron1; v: pron2`
    (where "n", "v" etc. are POS tags). Redirects are written as `word:>
    target`, e.g. `colour:> color`. Generated by the `dictbuilder` program.

## History: Steps used to Generate the Phonetic Dictionary

Some of the following steps require manual intervention. They are described
here to document the history of phoneng.

Downloaded and installed knowledge sources:

  * Downloaded SCOWL and VarCon from [SCOWL And
    Friends](http://wordlist.aspell.net/) -- version 2014.08.11 was used to
    create the distributed dictionary. Unzipped both of them within the `data`
    directory and renamed the resulting subdirectories to `scowl` and `varcon`.
  * Downloaded the [CMU Pronouncing
    Dictionary](http://www.speech.cs.cmu.edu/cgi-bin/cmudict) -- version 0.7a
    was used to create the distributed dictionary. It's enough to download the
    file `cmudict.0.7a` and store it in a new `data` subdirectory named
    `cmudict`.
  * Downloaded the [Moby Pronunciation List by Grady
    Ward](http://www.gutenberg.org/ebooks/3205). Created a `data` subdirectory
    named `moby` and unzipped it there.

Invoke the dictbuilder program (written in Haskell):

    $ cd data
    $ dictbuilder

This writes a file called `phonetic-dict.txt`.

Manual changes to `phonetic-dict.txt`:

  * Changed "Beadle" to lower case.

Invoke the partsplitter script:

    $ partsplitter

This writes a file called `phonetic-dict-candidates.csv`.
