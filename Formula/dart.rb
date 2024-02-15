# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-140.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-140.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "658e0c7df99db0aaa8c90de59bbea65c96ca01e0458b13b0c8afb03ed1a8964a"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-140.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "0c1d4927486c5f314ad97fc1f8d2b730e064d2e902d5931cbcf95669454f3337"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-140.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "28d29d228a7ba6bf66c75c0d11fcdb49fe4c5e2d468dc8a8b226134d577d6350"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-140.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "1f6bc8b3380c09561fa1cf50943b359a882e2bfe4179dcf1ae10f198b1b15df1"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-140.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "fde6dc0c32429e05d336d4ea8a23410e914b88d1ac2a19384ba613ef51f2817b"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-140.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "bb5cac7c5bd74e69d2a854e5a41c1f38d2a0f5ee64cafc44c561522a9f568355"
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
