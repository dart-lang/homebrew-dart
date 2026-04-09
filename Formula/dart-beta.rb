# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.12.0-327.1.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.1.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b948790fea7fd537e323c2a0e8ddc7c2de3ae8e5f8b2d6ae504834ee49b43b16"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.1.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "90f40b67923a48e024da574694950220e71a699ec8e68599edf83d8384f322b2"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.1.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "8ca58464d189e83f050b08315355c198cf593843c971c17600e2b2ee11d6984c"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.1.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "d8ce436dd4aefff9ffc777c1d566f97272bda3d08544457ca8f0ec69fc8e19ad"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.1.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ef718700ec8dc7d361655b3bda9b943a815dc5069ffef2f8e57050251c8ed4be"
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
