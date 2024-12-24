# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.7.0-274.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-274.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "fe75fe74bad67e3f502480166f43eacdc062e17f0c0b131c0234e33a2e6e66c0"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-274.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "1558f39c30f0a2a0990f23bdf55906f4637f30811aad1a5ad6b77a2fbc2fc6bd"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-274.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "5a8b2c879845910ea3559daa453b8edda796974d3d69ddba0d04fc8d1856d717"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-274.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "f4aa66fd955cd865dfe0ae520319ad386d1962c9e45c971603a4fff11ce24a3f"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-274.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "947291f4cf3c693c0bae019fc31e48d736888bf152dcb0029557b833ccff1a0c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-274.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "082fd551ce66a2a0640c18c6ea0fb0f854f5e47e9701d616c5ccb05f49262699"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b859b1abd92997b389061be6b301e598a3edcbf7e092cfe5b8d6ce2acdf0732b"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "1bdbc6544aaa53673e7cbbf66ad7cde914cb7598936ebbd6a4245e1945a702a0"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "8e14ff436e1eec72618dabc94f421a97251f2068c9cc9ad2d3bb9d232d6155a3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "7c8fe91f6ca9f7b2f8216a34e49e9963b38fea8cda77db9ee96f419ec19f114d"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0f82f10f808c7003d0d03294ae9220b5e0824ab3d2d19b4929d4fa735254e7bf"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.6.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "7281158159d65d35d0bee46a97eb425f3efcb53ca3e52fd4901aac47da8af3fc"
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
