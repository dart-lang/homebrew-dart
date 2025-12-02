# typed: false
# frozen_string_literal: true

class DartAT3103 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
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
