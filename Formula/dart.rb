# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.4.0-34.0.dev"
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-34.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "308b6e123cd23ced3c57f04c726ac27e79f3a4c9f4e130438a9faa0314e891bc"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-34.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "1201f5b17db5a7f7354df2a170a229b12b7937f0d96ed1a48746fd51b1ea6790"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-34.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "1b5d85572dc5c5747728f4187ee1e9253098a3af1a8bf6cc71173bb497c67213"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-34.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "becab31e3714bde2a9388f3a1fe63e2a36d4d23a68824fd1b309a102fccbd04d"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-34.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "5e577e282d4cd3405fd697335110d3acd562da61935cc1b07057a136abb149f7"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.4.0-34.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "89c228495a047370440547550ccd705c83f7cec238fb07aba82f107f39c291ac"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.5/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ec4891331e3424418ea56976f262a408e8d7655b2917dcb5844557a7c971d349"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.5/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "a218f96080403e261c5986ce0ed4c4ee3f9d872b800f34540c2a8526cbea6b52"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.5/sdk/dartsdk-linux-x64-release.zip"
      sha256 "e35e66f6cb5f511eb909fc27f9cebe81712925b6abd4494310003cdf26410ab1"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.5/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "42dfeb6b00f01cf449c9fceccbb4805d50ebaa5129164d897e4c465ef7223f60"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.5/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "aa840a615e90fc26ca0ca348be8359b254a144cff6a0e2c3f7eb361ed9aef393"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.2.5/sdk/dartsdk-linux-arm-release.zip"
      sha256 "9b08a544e8e6438c136fcef04348e0b796ee4125eab291b2657b56b3df60e8dc"
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
