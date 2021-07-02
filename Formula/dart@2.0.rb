# typed: false
# frozen_string_literal: true

class DartAT20 < Formula
  desc "Dart SDK"
  homepage "https://dart.dev"

  keg_only :versioned_formula
  if OS.mac?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.0.0/sdk/dartsdk-macos-x64-release.zip"
      sha256 "7cb9e65cea94ce23b05af4e5224ec416b26c3fb6bf0718778b68f6a73e617cc3"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.0.0/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "da55f8fce70ca46e97304810406c89f039464be909b9b92f13986ce918da6775"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.0.0/sdk/dartsdk-linux-x64-release.zip"
      sha256 "4014a1e8755d2d32cc1573b731a4a53acdf6dfca3e26ee437f63fe768501d336"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.0.0/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "3164a9de70bf11ab5b20af0d51c8b3303f2dce584604dce33bea0040bdc0bbba"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.0.0/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c49b9dab20de785c560db1347c2ad5b2d88d2ea45b3ec4a0d86cae058b793076"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.0.0/sdk/dartsdk-linux-arm-release.zip"
      sha256 "5a3679062674925b4c065266cc2fe18ced90b65fbc2982b036c2593cd55d5e8d"
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
