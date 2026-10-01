class EuerDatev < Formula
  include Language::Python::Virtualenv

  desc "DATEV-Export für euer"
  homepage "https://euer-buchhaltung.de/datev"
  url "https://files.pythonhosted.org/packages/dd/47/b3548d36b896e5b3f442789b2bce396a7881b18b9172e04e71f66e67faec/euer_datev-0.1.0.tar.gz"
  sha256 "9bb7272df45cad61cc7432413f4c3509b45ac26062cece7b847e1e6133326e44"
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
