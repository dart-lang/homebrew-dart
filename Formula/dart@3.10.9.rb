# typed: false
# frozen_string_literal: true

class DartAT3109 < Formula
  desc "SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.9/sdk/dartsdk-macos-x64-release.zip"
    sha256 "a5ddfbbd60ce20a19d7a4fc2b94487eec57288aaa52ce5ba18b4f8224ce4c180"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.9/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "f7d80c86f93348999812c1ae0f79013757b797af395f2cba70d2027a00be564e"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.9/sdk/dartsdk-linux-x64-release.zip"
    sha256 "d43b9d3a21b82ef2a37d31945b99e6b88f5f8dc44ec191b473fd629d78d0b994"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.9/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "67c98f9e6a694ed3cb362634372d69473040b3712836d42cafcdb3c56c0a04eb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.10.9/sdk/dartsdk-linux-arm-release.zip"
      sha256 "6522808eaed1e0050a4185f296a5ce272663a55da6fc8d45aa6835929937ba97"
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
