class EuerDatev < Formula
  include Language::Python::Virtualenv

  desc "DATEV-Export für euer"
  homepage "https://euer-buchhaltung.de/datev"
  url "https://files.pythonhosted.org/packages/3e/47/25533c1f7ddeb637f071d83c410d9348df804beac1ab9b267641daec3f17/euer_datev-0.4.0.tar.gz"
  sha256 "b0ee3a75a1b5bbd99aa3f2da2ee2691b36f7bede3ba9ec005de3478496eef849"
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
