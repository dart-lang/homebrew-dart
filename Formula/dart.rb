# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-94.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-94.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "072377a32ff7a31c4a6d1f668594a65aa998e7b2394183f5f8f3720b376df6ef"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-94.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "cbdeded394c8f80871d6d65c5c0e19f512849ff3098c6f3346fda48dec3b2ee1"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-94.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "3e23d0322e759dd26f117d156339e824aed2a70bb71ee35c3e981678d2187e33"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-94.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "f043ef709d45fd131debe342243f8959024b6a25447afca243b734687c94559e"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-94.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "c832cc36bbca660097d40e37e7fc196e39bbe9b7df3a13d2ef68771ea436dbe1"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-94.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "e02b13b35d5c7cceebc970555e5f5e7b54e680064e8a7e2c94000270c7e741e9"
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
