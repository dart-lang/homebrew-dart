class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  version "2.7.2"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.2/sdk/dartsdk-macos-x64-release.zip"
    sha256 "529281db2b4450c1aabdda0e6c53ccfa5709869dae56d248fb62365c0ea03f84"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.2/sdk/dartsdk-linux-x64-release.zip"
      sha256 "9b1434cd60c56aa39d66575b0cc9ea0a16877abf09475f86950d571d547b7a6f"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.2/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "158d984c679c0099f8e099ca351f30ab190dbf337a8fd30b63e366ce450b4036"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.2/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "57a856e0fa199b6c9e80182a1a9c5223d2e1073be6d5a6eaf560cf00db74c6dc"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.7.2/sdk/dartsdk-linux-arm-release.zip"
      sha256 "dbab7fe86ba5b2a8b4c99ea7055bf8bc681c7804503b844a9ff1061dce53ea12"
    end
  end

  devel do
    version "2.8.0-dev.17.0"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.17.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "ba030db7ba6c30699ef6a51e507c7d78c2ad437067afe81870475cef62e08387"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.17.0/sdk/dartsdk-linux-x64-release.zip"
        sha256 "031039ee560a40ecab6d69216b23a58c66bd57db8a49006140940e3d2ec9eb54"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.17.0/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "96faccfcdf686431d2ff5689a2d9051cdd4827827718e4d229380b1b0fd7f66e"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.17.0/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "4602c406fa93038db43fe598b34ed3221ea5b4d48c200418931363b39b7fd6db"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.17.0/sdk/dartsdk-linux-arm-release.zip"
        sha256 "2e6b27fc4b5b4c38d0502616e67c550d85950cf6cf43e1d431cc0abb5b3c2b7b"
      end
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,dart?*}"]
  end

  def shim_script(target)
    <<~EOS
      #!/usr/bin/env bash
      exec "#{prefix}/#{target}" "$@"
    EOS
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
