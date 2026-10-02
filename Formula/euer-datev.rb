class EuerDatev < Formula
  include Language::Python::Virtualenv

  desc "DATEV-Export für euer"
  homepage "https://euer-buchhaltung.de/datev"
  url "https://files.pythonhosted.org/packages/5c/89/a5fd1b025d8b775794896849a9ff9772a1f285a4b61403aa7eb445dc983a/euer_datev-0.3.0.tar.gz"
  sha256 "dad17f8c30aed9d425d3b99dc8481668777e525c3b56f73c725899ca990a6907"
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
