# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "2.15.0-164.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-164.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "96e2d27b70246a82018d338d9fe5106d7b292cbccd6e1f305833edb485bee6e4"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-164.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "48688633ca9704bd2a88bb023ea6853a024df7449aa97832b920283c19e72cfc"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-164.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "2c4cba78a690b0dbde9ce199bbf7f7128eb76f16a5e6fd3b21755bc2ba3bacc6"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-164.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "e39c5f43f7fbc47d4886f3002217d2302756e6eac3b655c4277a4ffd36201016"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-164.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "180930720e17a7152a426e0387fec5058e4acc8f57318bdb4a2a3e96e9d26219"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.15.0-164.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "43ac8b6d94ab7edb3b7b96aab18b93bb0ba328203154e0650f7b155cd0df6de6"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "388a9ccaf548033dd6472b3de895f96a625902139f751d2559de8098d27f4447"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "4e7af53c77bf862a16c3b9291583f7a3ec08f87c8adaff2553b7c3d02bdf8844"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.3/sdk/dartsdk-linux-x64-release.zip"
      sha256 "cad36ec238af96c8048bbcec4cff7e69fcb1b895620010ca1762674ca4ade171"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.3/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "b7c817e416b76f6ab1fd2db47fa3e88f15edf9e1e91dc395b2a00e03e998d23e"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "a6ede5f0d93ab53b619871c31c274d1fb63c23be1661690bf25402359cb5fac8"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "211613701a128193d4b3596be910a887e0d7f54c9221620badd5d277b34287a7"
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
