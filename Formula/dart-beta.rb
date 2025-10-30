# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.10.0-290.4.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.4.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "266a830f1172134f53a27ba6eca28efd99d0f8d525544348637225ab9e96656f"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.4.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "79045013bfca24c5a63ff1d0ad0de5e6e14258b1e7f9a889b61718ab9e3706d0"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.4.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "40132ac8b651895e76011d54d5703cc5a2e126cd396f75a0d9f24729b4f9c79d"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.4.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b440bb5f329c07161ab0396bbc8f739d9c547067cb98b9882932a048bebff62c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.10.0-290.4.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "bbc36ed5076a95609cccbc6f76f7b077f998acdd4b7f6a22ff66e32412fd5dcf"
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
