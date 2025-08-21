# typed: false
# frozen_string_literal: true

class DartAT214 < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "c900f6ccb62e2f7526f457d00be8fc296e7c2ce9c7653cf007b5a4db7fe9a9ae"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "49b6a98008ef546cb9c221461529d6c02cf2474bff098e0dc7e4ff1ef0f8a289"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "f6b73006af2e3bd1394877f2e539ef88ae6a93968a56d4124e3b0b5d68b4de36"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "0477fae6fcff58fec18d912537f13d647fa0e137fce23401eea73102dce62351"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "796b64022615ea75f05f20a3d5e7018e52a1d26c06acb1d2b0b2faa5df491a64"
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
