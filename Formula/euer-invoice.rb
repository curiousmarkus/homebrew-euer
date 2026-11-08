# Generated from immutable release artifacts by euer-invoice/scripts/prepare_homebrew.py.
class EuerInvoice < Formula
  include Language::Python::Virtualenv

  desc "Lokale E-Rechnungs-Engine für KI-Agenten"
  homepage "https://euer-buchhaltung.de/e-rechnung"
  url "https://github.com/curiousmarkus/euer-invoice-releases/releases/download/v0.5.0/euer_invoice-0.5.0.tar.gz"
  sha256 "e8a3cee1dbd7e2eeb4e911ae3f0c3894a57303053d944258bbf62a4b2a51224b"
  license :cannot_represent

  depends_on "openjdk@21"
  depends_on "python"

  resource "toolchain" do
    url "https://github.com/curiousmarkus/euer-invoice-releases/releases/download/v0.5.0/euer-invoice-toolchain-0.5.0.tar.gz"
    sha256 "60bddcb99766c6f72fd9ec7953628991bd692262dbdb51cda8b7630a91a3b304"
  end

  def install
    virtualenv_install_with_resources without: ["toolchain"]
    resource("toolchain").stage do
      (libexec/"toolchain").install Dir["*"]
    end

    env = {
      EUER_INVOICE_JAVA:      "#{Formula["openjdk@21"].opt_bin}/java",
      EUER_INVOICE_TOOLCHAIN: "#{libexec}/toolchain",
    }
    (bin/"euer-invoice").unlink
    (bin/"euer-invoice").write_env_script libexec/"bin/euer-invoice", env
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/euer-invoice --version")
    output = shell_output("#{bin}/euer-invoice --db #{testpath}/invoice.db doctor --format json")
    assert JSON.parse(output).dig("toolchain", "available")
    status = shell_output("#{bin}/euer-invoice --db #{testpath}/invoice.db license status --format json")
    assert_equal "free_quota", JSON.parse(status).dig("license", "tier")
  end
end
