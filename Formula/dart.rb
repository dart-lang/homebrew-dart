# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-116.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-116.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "9b0f596fd61cd916edbbb35ff1eb88c2b369f51d736cd8b1d3931e9a407c1a14"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-116.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "f67c6e0adacd7b6f8715f90deef0c8525a987f7098ce407d19e2395540a23e66"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-116.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "c227c83b6341b03fd8cfaac2f44be065d5d170735e6b4d10c3b1920aa9c7ddfb"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-116.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "69df284ced737ca2b0a033715b5ebf065af44142fe5d7b145b6596168974ae41"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-116.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "f31866e32a2fb69bc6d278c63fb4945b9f88b1359a10297baf14ad0424c790b0"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-116.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "78eedbabc784daf3e72fe543be6b3dfedff8b9366bcdf88e5642cb94e5eb1a30"
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
