# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-108.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-108.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "896ac9f7a435064b79b8443dffb8bf671cfa2ed1a5e94967a61ff73781d0b2cc"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-108.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "657e1d2e26b1f6cda84aa92125e9d861e70bf298d82cb69dbe76388ae9235234"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-108.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "20183d3f7af080c20361887ba9d1c4687d6084ccd25b82f50319328acb0e250f"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-108.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "6945aa2c28059d4b1d018778264343d8a1674d4c99b2b485c90c14a6b156313c"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-108.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "2ed2d0f14cf78e9d9307ae7557d37490682ae42550285951eda81f0f061f5515"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-108.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "b9f6448836fb118432b4b73a8b0661f9637d6aed5231af783a74d042be0990ff"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.6/sdk/dartsdk-macos-x64-release.zip"
    sha256 "97661f20230686381f4fc5b05a63c6b5d5abc9570bf93ad4e5fc09309cd98517"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.6/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "2e04c91039f9cc05b2e93ce788aa1ce08bc4df5b50c84d6b4e21ba2b2538adb6"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.6/sdk/dartsdk-linux-x64-release.zip"
      sha256 "253390a14f6f5d764c82df4b2c2cf18a1c30a8e1fe0849448cc4fedabaaf1d48"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.6/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "91f106e29013e2fd0f0b58e18cde0f026997d5d9d55ac747a319b8d3ec6e8956"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.6/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "9818a37dd39e8e91a0159bdd2522213f9d36bbd99b715465b4606190e6ae41c3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.6/sdk/dartsdk-linux-arm-release.zip"
      sha256 "ee647813284e4464a46ffcf9af36ef8d891494056238f7b52a0485fcdefedb5a"
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
