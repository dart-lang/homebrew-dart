# typed: false
# frozen_string_literal: true

class DartAT390 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "ad1ce35fff59b4eda1ff9d7e89d1e5d31cdab86192f3bdaf93baa36f5ae4d8bf"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.0/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "fbb401da7e2fd012a7ecb80b9c044f9c73b26ccf6bca59118239f9c9689ae2de"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.0/sdk/dartsdk-linux-x64-release.zip"
    sha256 "75bf2badc56cd6aff829042a0112ca5f3cf50bcf7fd95c29bc76650579dc00e1"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "e9a028b0be5325e2cbf5118ab6c6c407d302fb220ae5dc7d9d6f5648676fb724"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.9.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "c2bc9f74f3d77ff5e2d66b10eb9acb81e1978ef7ec88772a8a0231d0dbc526ac"
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
