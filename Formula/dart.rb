# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.19.0-269.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-269.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "dba036cbd176eecd84058d904fb830bba0b4bf642b1d11ff080eaa47d1300a09"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-269.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "d92ca1a3f69ebf98a96c687aa99ea98da99dfd1c7b72ae2575767f5bdd363a82"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-269.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "125225db1593aa3336a241fd2dea6c1f5553fad85af288ac18ca2bd009746842"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-269.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "9eccb1de770ed03b3a10d0ab9666ab65bf0a2a8d2291ccec406df3f75a52fc98"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-269.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b65b3a261d48b0429b1246b39d51d0c0d933342413f71f7a0733e31f0c31c4dd"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.19.0-269.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "6c552ed939a4fe97489612d003cefd4e37cef86d8b1e3caec2e0763e54d456b5"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c5c478d97f64b7bdfb5ac4e5c25724af177257691a17c9cfc1b59b069159e61a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "49fed61ac432440b2817666c8c09040cf586a66536d4ddd9e963dfbc30b29fe3"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "0b7f988de7172ef4a626b2f08bd1fb4e00fd369d0002b456c7711d06b7d0a535"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "87bf5924eae72138708593e24636817f075d38885a6ec08a3de37397f4877e48"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "cf220ad62e7ff4fd82fac8f3740ae1170a553b83fe22dfbf5f9d25fa7f607a42"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.18.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f14ec4fcc222c88dfd5d1fec47ac527ee172e5b974974de9a7c5213922d05e70"
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
