class Dart < Formula
  desc "The Dart SDK"
  homepage "https://dart.dev"

  conflicts_with "dart-beta", :because => "dart-beta ships the same binaries"

  version "2.10.1"
  if OS.mac?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.1/sdk/dartsdk-macos-x64-release.zip"
    sha256 "f2dc5d040e908183b3797c68e03cadf7fc1f4f23092651b2b39f7bdb38e4c37c"
  elsif OS.linux? && Hardware::CPU.intel?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.1/sdk/dartsdk-linux-x64-release.zip"
      sha256 "3795860f2d27b0aebad25e5a9191c2534ecbe613133572f565201d50072da4db"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.1/sdk/dartsdk-linux-ia32-release.zip"
      sha256 "bb7b7743d89b2c518147d67f16dda135bebf02f289acefd27c3e97ad0e828a27"
    end
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.1/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "6b4e8a05283cc88f0607eb0e89f21494a5e5ee42d598860119e52b8ef5a207cd"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.10.1/sdk/dartsdk-linux-arm-release.zip"
      sha256 "f341167b34fdfd55751601e7ebc2dd1e9db3aa8a74bf765d6090f92878cd1ef7"
    end
  end

  head do
    version "2.11.0-180.0.dev"
    if OS.mac?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-180.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "db042a7b8f9e77cbbd62342017c0770c72743e88d815db3f696e873bd7fc67d4"
    elsif OS.linux? && Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-180.0.dev/sdk/dartsdk-linux-x64-release.zip"
        sha256 "c8793c43770aede5627043214820d3e07741880aacf1231155b059bff455fd28"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-180.0.dev/sdk/dartsdk-linux-ia32-release.zip"
        sha256 "4606374b4dc248ce3dab3960a90fe186ab948fd97a0c3b3e5d567fe816d3e686"
      end
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-180.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "cb5c4823c93dbf44e5a2376ae00f92f388e8710ff94c3b0aa06187f42962028c"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.11.0-180.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "c07778a14f0e5e51ff0bf04fda1ff05534285c5e72e6158196673486b8195bb3"
      end
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
