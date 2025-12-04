# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.11.0-190.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-190.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7bde5bca40e8f2c4c03b338e5c4fe6c99939201a83a7d918dca68fa4c6995d11"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-190.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "65135f432c3ac7c82d5381b4b5330c30de0f77e56e0d64095f0078189e073137"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-190.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d599cdfdbcf645b43167b1eac74348c9f0ac0aadca2cb08f8747ad5b3a5eaf45"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-190.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "7204a12a44882bea235a519a42ed3ff3889cb01614f5eda85af85ad57e1acca2"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-190.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "0313624b9bc6a8bb61c16fe0f22ebc73d5ce023ee830bd081907da3783b736da"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "b49f2f88782f17b3935e53faf906d4f5adf5e0298ec9a3608e0f33fd81c2d7a7"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "5bcbdb9b59c2012e1c91dfb584e23075f325293c35d1f943e50012a223d62f93"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.3/sdk/dartsdk-linux-x64-release.zip"
    sha256 "db95cd3bbdb604ac1d2b8fc7a1524c909a67dfd44bff1fb4a075223b7d829e0f"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "478986a2089cbfc6ac169bad356f90b13e291cfa4728e39fd45ac357ef7fa7df"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c9c63650ef6255cf979ae3382b25fe3c158be7d28522f91bf4a43ff099425bb3"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"].select { |f| File.executable?(f) }
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
