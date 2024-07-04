# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.6.0-2.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-2.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "a4dc6212b9bd0e2d1e914b351c58ebc4ea0197849e1e70134a5d80906257d559"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-2.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "f83bbc1a37d7c20caa6b6423b79703dfea63478d4bc46cfaa4ec3aeb7d59d9c8"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-2.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "7ce1143f6cc95c08fdf2126ebf1b8d366e256f78b946dabcee7499bc680b1035"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-2.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "d6aa3886fc5859fe1272ad4c8cf7b5754726d71813945b22251616556d790a23"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-2.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "b8a464489dcedee657693958939622f7ddfe5122070da5f476fe2cc9515ee476"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.6.0-2.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "58fcebea89469c0646571cc69f149ea9de854cbcc1d345164a3a10663778c5e9"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-macos-x64-release.zip"
    sha256 "fda7beb096ef3a2311f4f11ab774146fc8352fc73f154132f7c76404a780f9c8"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "ca750214e3fe0f88c0fb07b22f523c53a307c184f2ed51c3d3dcd2cb9e7bc317"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-linux-x64-release.zip"
      sha256 "1968cc9ee12802317f9a2320165f6966cf949dc3574cac1cb91a1bc7f0de67db"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "a2ce567c7953c901af15e5ce89436d611f601bbc64f0f4a920700e9f1d61f902"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "b4cee491863d2ca6c324fad2d8fe2dfa123f78164630d7ca5eee45b940f70346"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.4.4/sdk/dartsdk-linux-arm-release.zip"
      sha256 "2ef98f20dd52440bc664d7f215ac888a40755878a0e96cd4356a8cbbf0c20b6e"
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
