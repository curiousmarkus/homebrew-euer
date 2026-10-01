class EuerDatev < Formula
  include Language::Python::Virtualenv

  desc "DATEV-Export für euer"
  homepage "https://euer-buchhaltung.de/datev"
  url "https://files.pythonhosted.org/packages/14/6b/a49abeb00bd5796690d70af5f1f6ec8f0e6cf124bdd1abf38f9cefaefe8f/euer_datev-0.2.0.tar.gz"
  sha256 "5f100d25f4b4e9e949602dcabdb287598ddb0d4b5acd8e3dff6d780aef95b743"
  license :cannot_represent

  depends_on "python"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/euer-datev --version")
    assert_match "[datev]", shell_output("#{bin}/euer-datev init-skr --skr 03")
  end
end
