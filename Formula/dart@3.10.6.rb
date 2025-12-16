# typed: false
# frozen_string_literal: true

class DartAT3106 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.6/sdk/dartsdk-macos-x64-release.zip"
    sha256 "13c0c9683d7486e0e20204aa81823b83a8e03f247bc36df8daba61be0957dbe7"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.6/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "262b9214c8948b80419dadf3cf9a08f6ddf9ba70b31a5dd945d9757eaf7a67c3"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.6/sdk/dartsdk-linux-x64-release.zip"
    sha256 "6c2ec3ec17956bf868255fb30c8f9330dc7615dcbd5df252cc1ceba87aa22735"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.6/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "2f4bb013b7efbca6f9178795c2ca4bf1f3d4874abfc18da974566cc2d9a65aec"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.6/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2bd447cb87dec1584432968b2d1637b466960bd367528287fe907a73854c8c95"
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
