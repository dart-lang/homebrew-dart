# typed: false
# frozen_string_literal: true

class DartAT3101 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "462436904165ba6d3c72d265c019a5de63da2294edfd903d06073b3992b544c2"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.1/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "37d233029f48b75b368a35f0fa1eb728fc5780a03a4b28a2ec3bcc343884a6c8"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.1/sdk/dartsdk-linux-x64-release.zip"
    sha256 "a352fd18e0c07aab694bba9cf57e431eddce390550a90449b1ff880fee7736f4"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "60d33687806781175723f4cb7def7adf83ee0f981ca997d2eece40f975526b4c"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "4b2e148019dfa1c1703ccc86aea45fe711ed09f190d853a26c172b5b962bf5bd"
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
