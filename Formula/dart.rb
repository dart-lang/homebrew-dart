# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.7.0-243.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-243.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "788a0404c3ee758fe6ffc1f20839311de37ed2b44244afe117c6c1dd0273a0ee"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-243.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "a54a89627063a9d4c8d9f7745bb4e2335b3e1d12cff62eed0b8484ebcbf0cd47"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-243.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "072288af973abb19bc66c7739d62711501eee1dcad80c5e6c0aa075830f82fdd"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-243.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "5796090c5813bc79fba3b6fa20ebc13105f4e5d0641176c014e25c49c33e3dc8"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-243.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "2035a3b31fee809180387e00cfd85f818d278d9abf5a13572b1779badc1050a6"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-243.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "6d6a6b427e71974aba68894126989090940a4e2f2b6a9822945da9653b8f02ce"
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
