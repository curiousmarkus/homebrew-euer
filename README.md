# Homebrew-Tap für euer und euer-datev

Dieser Tap enthält die CLI `euer` und das separat installierbare DATEV-Modul.
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
