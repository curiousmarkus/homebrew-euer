# Generated from immutable release artifacts by euer-invoice/scripts/prepare_homebrew.py.
class EuerInvoice < Formula
  include Language::Python::Virtualenv

  desc "Lokale E-Rechnungs-Engine für KI-Agenten"
  homepage "https://euer-buchhaltung.de/invoice"
  url "https://github.com/curiousmarkus/euer-invoice/releases/download/v0.3.0/euer_invoice-0.3.0.tar.gz"
  sha256 "91ff44ea92aa9c4e16eb508c1b86d8c55f713dc44d0a23bd9c9f64444bdeee28"
  license :cannot_represent

  depends_on "openjdk@21"
  depends_on "python"

  resource "toolchain" do
    url "https://github.com/curiousmarkus/euer-invoice/releases/download/v0.3.0/euer-invoice-toolchain-0.3.0.tar.gz"
    sha256 "c0274113e2d7340d3393731e3b8eea7a902a1a5c3c45b2ebbe29bae60686166b"
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
