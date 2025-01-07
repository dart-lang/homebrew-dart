# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.7.0-301.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-301.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "e0bf858177bb1b13b6767ceaadbd02b43a266a088cc46a027707ad8726ab23de"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-301.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "8444fa15f75407756c68c188f30027a64e0cd8a1608d09e0319894a07fab21a8"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-301.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "1c75e779ff3d407c912bb40e8c8d91f811879d6822648c1e611043edb5c746e5"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-301.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "260d6fc150c61eabfc2b9d1f95bbc2f2d85ab6f579c7eef05c70865f32ba942c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-301.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "c5780adc42a6a7baf8f76268e6cf6b9695a62a5f59bb189b6da89a99c0605245"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.7.0-301.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "4333fa567c4c8ff9fa7bc776a26e0bb9aa4431768b8b090f35140082d3ec4e3c"
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
