class Pputil < Formula
  desc "Lists mobile provisioning profiles on macos"
  homepage "https://github.com/juwens/pputil"
  url "https://github.com/juwens/pputil/releases/download/v1.1.13/pputil.arm64"
  sha256 "ead46757983e0af489256f94f322fbcdd3f16d1fde9438819babb35a0711686f"
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
