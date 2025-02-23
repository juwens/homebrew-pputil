class Pputil < Formula
  desc "Lists mobile provisioning profiles on macos"
  homepage "https://github.com/juwens/pputil"
  url "https://github.com/juwens/pputil/actions/runs/13487502437/artifacts/2638094498"
  sha256 "2f8273160053d7d4721f2e6588c18ace7d1d6ed7961d804cc3b48afbd6c42671"
  license "MPL-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # it's hard to create a working signed provisioning profile file for test
    # hence we we are limited to basic smoke tests for the time beeing.
    shell_output(bin/"pputil") # only assert exit-code

    assert_match(/pputil [0-9]+[.][0-9]+[.][0-9]+/, shell_output(bin/"pputil --version"))

    help_output = shell_output("#{bin}/pputil --help")
    assert_match(/Usage: pputil/, help_output)
    assert_match(/Commands:/, help_output)
    assert_match(/-d, --dirs/, help_output)
    assert_match(/-h, --help/, help_output)
  end
end
