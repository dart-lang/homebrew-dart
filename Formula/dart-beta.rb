# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.12.0-327.4.beta" # beta

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.4.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "d0f78139d6d0f3dc209c0a08870fddad1aff2ca970f8b27a6dc239b283b6b7d5"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.4.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "b001486385ab55711f6c724ae738934f627d293ed3f7f7d113e0e31f3f26975a"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.4.beta/sdk/dartsdk-linux-x64-release.zip"
    sha256 "60484d3bb620de44f11b0078571f288fe1b5c6207369e4a5a92a0d942fe183d7"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.4.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "1053dde7acf75a594b81f1612e7eab427a62b69f73339667b87f6224e705e695"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.12.0-327.4.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "bd92bd905c5208ce6b7063db7a820ae78d90b9d4c0b6a9d1091e794a93721d8d"
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
