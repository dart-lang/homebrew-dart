# typed: false
# frozen_string_literal: true

class DartAT3104 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "29f6c7c28c635ac839519306c3ac1371eac9fbed4ff48b9bf58c3cf7cd1d76e6"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "724b64f7afe3847c8624c3b63ca709e93f498f586609031f7da48d8f1fa49147"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.4/sdk/dartsdk-linux-x64-release.zip"
    sha256 "60a9a34eb1165d331d776dc89fb4fd43b9d8bdaf2ca137c1fdcf98d6c89abeec"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "828faa614fc2dfcc0d0b44ec646f95d69433124ce0c81a546e75ddd8a5f9a4fa"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2dd412046e8d9fbe429c6fb5f1c042b27f081720c1f1e36a25cc367b7bbe7c52"
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
