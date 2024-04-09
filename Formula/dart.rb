# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.5.0-33.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-33.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "2583a75aee94333fcb965a2f4b39c566a9299c41170c202aa92f8f48e96629e6"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-33.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "efa6cd2519c3a588260a23d9fb50202a87a9759f80292c8c8eb4645c730431a0"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-33.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "ca3c156e5936b992732be8ef5d9174f883d5b444897c8a09efc0dd21df584b51"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-33.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "5652e61000be67ff8ec69b2d6b3da400e485820971ececde3a985132b9dbc915"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-33.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b71be2e9f0cc627d87fbf07d507a3431aba513a3eea2bcd42b903374e7e370b3"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.5.0-33.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "88ae538304cf36b15e4bd48bd9a034a9cbec19b875c4520451657834c4fb6cd5"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "33fe912cdfb48231424aef4a8847ac1c0fcdc76d28e8dcdc68504bd05980b42a"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "d84b2d0201976871f06ac63e516333c82d7c896abe14c0ec8785fe6dbf68b267"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "ac7a96f730a632a0960861a6c0bdced033d8c324f6054e6f7dcdea617d77efbd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "92069b915a365fe414d7ad98958e7bd752a47d1ba709be940590d59335a802dd"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "f3da7690e8b238e77fbf2535a0c3336c3ccfb226e431c926f58334910f7ba595"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.3.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "4e0759057c75c1cc3f3036ef4e09fa408742bbb562e6aeebef9c05a848d61d26"
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
