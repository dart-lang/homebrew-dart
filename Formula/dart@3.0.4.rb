# typed: false
# frozen_string_literal: true

class DartAT304 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "738c34bc63f77912b391d34cef121a92851053a759ba4a3187df4249a674e21e"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "10bd7379e619b509b726585523dbc276e03ed7aec1957cfb5e86bfccf0262bdc"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "fed758732d742df884d39770756eb9bd9fdb24665c24c96502a09e03a745fca5"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "206b978e824608710e6af3e3301269397ffdec46235fe1d602063b9a30560bde"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "d04dee8e097cdfe02f7aa2d51620104ac680291f9d3b772a7c788694e0934fc1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.0.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "36aebf7bf6d43574dc3f66872e1926e184dd2ef8641212240e57ab895403a967"
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
