# typed: false
# frozen_string_literal: true

class DartBeta < Formula
  desc "Beta SDK"
  homepage "https://dart.dev"
  version "3.1.0-262.3.beta"

  conflicts_with "dart", because: "dart ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.3.beta/sdk/dartsdk-macos-x64-release.zip"
    sha256 "3d2bd89f06dbd439e852846640f41b19cda78fdc8b60cfe9c29cb70182325faf"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.3.beta/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "551a788371454c7f138489d8d89c487069c117ed47e62e21ad379dc6e39ea8bf"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.3.beta/sdk/dartsdk-linux-x64-release.zip"
      sha256 "e3bdf39358dda7f0fd02b25d4d4539536fff53b4ab257da31a5fbbe42edc28c9"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.3.beta/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "5c26f3550c810500f5fb1b38d2af1d1ce658fe913642236be20d522fe0450192"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.3.beta/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "7e7c2d1d4c8c8a6a47d916f422ddad2d5497307a147fa860b7b063ffdd162939"
    else
      url "https://storage.googleapis.com/dart-archive/channels/beta/release/3.1.0-262.3.beta/sdk/dartsdk-linux-arm-release.zip"
      sha256 "5a521eb74b6d65bfca7780c444b8e69f6d54bb541600bd94fedbec4b67200a3e"
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
