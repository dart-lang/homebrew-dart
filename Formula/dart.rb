# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.10.0-14.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-14.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "af249db2df46619144ad276570e114c97135fc77145a919b073ce1cd4a5526e8"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-14.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "70a98ae14f325f86b667bf7bc23369d59e4445fbcdf16d09e3991939e7b6683e"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-14.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "2ae0847c5830b9d2f71f1025c7eedddcb1ea569526eade79c64101d0d2883f7c"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-14.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "8e518ca9bb272ca42d7f8602115bc2726dd2f74bdfc159383d638f2c2be53741"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.10.0-14.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "100d5c4a2aed60f0744564f360a39e1ae184267fe53fd141fde6009743257966"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "df47f9b0e344ce55dc7fc36b34f3cad2f51872550b8487e3dc7f90f6d951b891"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.2/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "3cefd840420a352977d364fd2eafb8a5f3a8515ae4263159f5b1044d6ba35291"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.2/sdk/dartsdk-linux-x64-release.zip"
    sha256 "2945baab11cf7472328e5573713993baf917957fad691c1461cabd5a096e8311"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "6057db4cd909e37ec5f7dcf34ac0a65bc34fb41330b4c3718c43db1a50e8906f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.8.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "250c7e7f77456213c6bdd90c731dfac77c3406a9832f3d2ba1719500f1af239e"
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
