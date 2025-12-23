# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.11.0-260.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-260.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "37559533e9c7a34b9649b0309911dab1ba534e3a8e682d2561607333985b5a5e"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-260.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "db700d813f7b28d0712d0658ddbf109dcedb8e370ac20e3ea1349922d83d6cd4"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-260.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "d82f6c4e01f7957f297d913016c6c4fb5e2e3ec0a73192081cd368deec05dbdd"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-260.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "212f13f9618e54d10e14f9fc495095812f9b1787ad1016917d50faf665703fad"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.11.0-260.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "8adcfc754f18cc83dfdea48cc1a14c92c1b6e57f5ea9583881db02a948a010c6"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
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
