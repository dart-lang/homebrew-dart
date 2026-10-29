# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.15.0-82.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-82.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "d45996354ae7bda63904b421d3714ed2e04f5d7e22cb61e9e30b66c26f74743d"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-82.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "491bfa2ae3dd6b67e00a7f9adbe86946d3752e3fec97b30338b4cf6326e90cac"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-82.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "6eaa7e1e2545d3993a1169a43082713d194fae24b7f1b87b9995b093a896f489"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-82.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b111713d09d8a9cca04092b31ac5b216ce15801e41154cdd655a55137646da5d"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.15.0-82.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "ac4470b2cfda045453256630f6aed2f4fe9b9f388d2a4d09d07f69dee0dbbace"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.7/sdk/dartsdk-macos-x64-release.zip"
    sha256 "44caf063178ac7680060fe14c2247532c652874d38f1016bf45cf475c86e44b5"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.7/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "9f972ee1e1139cb4f845f35c7c77bef269dd2ec727b239fb17a2ebcb66d0fb2f"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.7/sdk/dartsdk-linux-x64-release.zip"
    sha256 "eb99aed266efbcb615c6ae21c12f52cfe935b9f208bccc5fea7f64c21e867229"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.7/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "887cbb763bc4a1d6f3d7c34a6ea08f0f05211807abf98c06d6e4263907ccac1a"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.7/sdk/dartsdk-linux-arm-release.zip"
      sha256 "05de30a7f588bcaef5e826b27ef262bd48eba02e46dc14726d64df2d4845039b"
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
