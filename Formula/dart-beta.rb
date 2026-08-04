# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.13.0-282.4.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.4.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "6a6a7914cb1b0c351eaabbcee972aedd24a723d659a26b527d75c1509e457341"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.4.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "7be95f408c1e8da17e39720382d9b1675159fb8c80df5735e3c4541f59443031"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.4.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "ae426a461fde77e78e4a2fed380c694a88500a720465d45c6720c1051d443397"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.4.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "d4658eaae87b582899f6802a5d6a4ffa5ec510971a22f51c5bb3547b3030adfe"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.13.0-282.4.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "273dd080170b6a86474908117583e58e4dde2850d4784a021ca51b34c12696b4"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
