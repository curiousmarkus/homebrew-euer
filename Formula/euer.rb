class Euer < Formula
  include Language::Python::Virtualenv

  desc "Lokale EÜR-Buchhaltung für Freelancer und Kleinunternehmer"
  homepage "https://github.com/curiousmarkus/euer"
  url "https://files.pythonhosted.org/packages/b8/fe/59a8d8d0201b583c66f2def409cc59f11e235289c671e29018a96defd979/euer-0.9.0.tar.gz"
  sha256 "a4b353f85466237f7b82e25e8f7f9ba170f952fc200e595b76cc0dcad2d13070"
  license "AGPL-3.0-or-later"

  depends_on "python"

  # BEGIN AUTO-GENERATED PYTHON RESOURCES

  resource "et-xmlfile" do
    url "https://files.pythonhosted.org/packages/d3/38/af70d7ab1ae9d4da450eeec1fa3918940a5fafb9055e934af8d6eb0c2313/et_xmlfile-2.0.0.tar.gz"
    sha256 "dab3f4764309081ce75662649be815c4c9081e88f0837825f90fd28317d4da54"
  end

  resource "openpyxl" do
    url "https://files.pythonhosted.org/packages/3d/f9/88d94a75de065ea32619465d2f77b29a0469500e99012523b91cc4141cd1/openpyxl-3.1.5.tar.gz"
    sha256 "cf0e3cf56142039133628b5acffe8ef0c12bc902d2aadd3e0fe5878dc08d1050"
  end

  # END AUTO-GENERATED PYTHON RESOURCES

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/euer --version")

    database = testpath / "euer.db"
    output = testpath / "xlsx-output"
    system bin / "euer", "--db", database, "init"
    system bin / "euer", "--db", database, "export", "--format", "xlsx", "--output", output
    assert_path_exists output / "EÜR_Ausgaben.xlsx"
  end
end
