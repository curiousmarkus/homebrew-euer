class EuerDatev < Formula
  include Language::Python::Virtualenv

  desc "DATEV-Export für euer"
  homepage "https://euer-buchhaltung.de/datev"
  url "https://files.pythonhosted.org/packages/ef/f4/c29a0518bdea4c3bbad91d40c0548b5f97df6802c8f0eb0212d45923d9b1/euer_datev-0.5.0.tar.gz"
  sha256 "7c89f0b2b8c619867d615e37cca8d3cb64220a1f40664492718f7c23eec9635e"
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
