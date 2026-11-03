# Homebrew-Tap für euer und euer-datev

Dieser Tap enthält die CLI `euer` und das separat installierbare DATEV-Modul.
Zusätzlich ist `Formula/euer-invoice.rb` für die Veröffentlichung von euer-invoice
0.3.0 vorbereitet. Es installiert Python, Java 21 und das vorgebaute KoSIT-/Engine-
Bundle ohne lokalen Maven-Build. Nach Veröffentlichung der zugehörigen Release-
Assets und der Formula: `brew install curiousmarkus/euer/euer-invoice`.
Nach Installation beider Formeln steht `euer datev ...` zur Verfügung, sobald
`euer` den externen DATEV-Dispatch unterstützt.

```bash
brew tap curiousmarkus/euer
brew install curiousmarkus/euer/euer curiousmarkus/euer/euer-datev
euer datev --help
```

Der Workflow prüft alle sechs Stunden PyPI auf stabile sdists, aktualisiert beide
Formeln, testet sie auf macOS und Linux und committet exakt die getesteten Dateien.
Für lokale Wartung:

```bash
python3 scripts/update_formula.py Formula/euer.rb
python3 scripts/update_formula.py Formula/euer-datev.rb
brew style Formula/euer.rb Formula/euer-datev.rb
brew audit --tap=curiousmarkus/euer --formula
```

`euer-datev` hat derzeit keine Laufzeitabhängigkeiten. Wenn ein Release neue
Abhängigkeiten deklariert, stoppt der Updater, bis ihre Homebrew-Ressourcen
ergänzt wurden.

Die Invoice-Formula bleibt bewusst an das zusammengehörige Python-/Toolchain-
Release gebunden und wird nicht vom allgemeinen PyPI-Updater geändert. Sie wird
im benachbarten `euer-invoice`-Checkout aus den tatsächlich gebauten, geprüften
Archiven erzeugt:

```bash
python -m scripts.prepare_homebrew --sdist dist/euer_invoice-0.3.0.tar.gz \
  --toolchain dist/euer-invoice-toolchain-0.3.0.tar.gz \
  --out ../homebrew-euer/Formula/euer-invoice.rb
```

Zuerst die exakt zugehörigen GitHub-Release-Assets unter `v0.3.0` veröffentlichen,
danach die Formula übernehmen und auf macOS/Linux mit `brew install` und
`brew test curiousmarkus/euer/euer-invoice` prüfen. Die Formula setzt Java und
Toolchain über einen Wrapper und nimmt die Java-Ressource ausdrücklich von der
Python-Abhängigkeitsinstallation aus.
