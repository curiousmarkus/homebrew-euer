"""Regressionstests für beide PyPI-Formeln."""

import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from update_formula import update_formula


class UpdateFormulaTests(unittest.TestCase):
    def test_datev_formula_updates_without_resources(self):
        metadata = {
            "info": {"requires_dist": ["ruff; extra == 'dev'"]},
            "releases": {
                "0.2.0": [
                    {
                        "packagetype": "sdist",
                        "url": "https://files.pythonhosted.org/packages/datev-0.2.0.tar.gz",
                        "digests": {"sha256": "a" * 64},
                    }
                ]
            },
        }
        with tempfile.TemporaryDirectory() as directory:
            formula = Path(directory) / "euer-datev.rb"
            formula.write_text('  url "__PYPI_SDIST_URL__"\n  sha256 "__PYPI_SDIST_SHA256__"\n')
            with patch("update_formula.fetch_project", return_value=metadata):
                self.assertEqual(update_formula(formula), "0.2.0")
            self.assertIn("datev-0.2.0.tar.gz", formula.read_text())
            self.assertIn('sha256 "' + "a" * 64 + '"', formula.read_text())

    def test_new_datev_dependency_requires_formula_review(self):
        metadata = {
            "info": {"requires_dist": ["new-package>=1"]},
            "releases": {
                "0.2.0": [
                    {
                        "packagetype": "sdist",
                        "url": "https://files.pythonhosted.org/packages/datev-0.2.0.tar.gz",
                        "digests": {"sha256": "a" * 64},
                    }
                ]
            },
        }
        with tempfile.TemporaryDirectory() as directory:
            formula = Path(directory) / "euer-datev.rb"
            original = '  url "__PYPI_SDIST_URL__"\n  sha256 "__PYPI_SDIST_SHA256__"\n'
            formula.write_text(original)
            with patch("update_formula.fetch_project", return_value=metadata):
                with self.assertRaisesRegex(ValueError, "Laufzeit-Abhängigkeiten"):
                    update_formula(formula)
            self.assertEqual(formula.read_text(), original)


if __name__ == "__main__":
    unittest.main()
