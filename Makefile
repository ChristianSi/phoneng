mypy = mypy --ignore-missing-imports

allpytests: pylint mypy pytest testdir
	echo "All checks and tests passed"

wheel: allpytests
	python3 setup.py sdist bdist_wheel
	twine check dist/lytspel-*.*

pylint:
	pylint3 lytspel/*.py

mypy:
	$(mypy) lytspel/*.py

pytest:
	pytest-3 lytspel/*.py

testdir:
	cd test && make

hs-install:
	cabal install

hs-all: hs-install hlint hs-test

hlint:
	hlint src/*.hs

hs-test: test-dictbuilder test-pronounce

test-dictbuilder:
	cd data && dictbuilder
	diff -U1 data/phonetic-dict.txt.bak data/phonetic-dict.txt

test-pronounce:
	pronounce samples/mad-tea-party.txt |diff -U1 - samples/mad-tea-party.pron
	pronounce samples/universal-declaration-of-human-rights.txt |diff -U1 - samples/universal-declaration-of-human-rights.pron
	pronounce samples/testcases.txt |diff -U1 - samples/testcases.pron
