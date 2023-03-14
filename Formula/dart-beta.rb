# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.0.0-290.1.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "877c13937520bd920f4e308cea6ea8b8826cfaa379f5d3243629c79edcb7fb29"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "8cad42d03ef692f775209b786a544d827e356309d6e5e5aac2fd44f6afc82a67"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.1.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "ad962441d3f9c5fb2d7717d6589fb2eceb781d38ca1703ce8caa9e2d88296e9b"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.1.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "01c898ad0975bd6ca839dfbe32bc859a0e20a0f6addb38d40cc8ecb26b0b7951"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "408304dec3abf68af0ec1f1a2f44165c88b95fe661027f2b7ca7dea482513f36"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.0.0-290.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "5c7283d15b040320aa0dd7fcd812f4102339dc5497238ea94b3bba5de1e67fbc"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def caveats
    <<~EOS
      Please note the path to the Dart SDK:
        #{opt_libexec}
    EOS
  end

  test do
    (testpath/"sample.dart").write <<~EOS
      void main() {
        print(r"test message");
      }
    EOS

    assert_equal "test message\n", shell_output("#{bin}/dart sample.dart")
  end
end
