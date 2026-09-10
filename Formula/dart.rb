# typed: false
# frozen_string_literal: true

class Dart < Formula
  desc "SDK"
  homepage "https://dart.dev"

  head do
    version "3.14.0-202.0.dev" # dev
    if OS.mac? && Hardware::CPU.intel?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-202.0.dev/sdk/dartsdk-macos-x64-release.zip"
      sha256 "006318644590e9b0e10b3c19b60449472818f45cb252477a59529d1f7783cfbb"
    elsif OS.mac? && Hardware::CPU.arm?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-202.0.dev/sdk/dartsdk-macos-arm64-release.zip"
      sha256 "d9b65f90f320a97d156664e604b8f062e79a69d3559244630fcc7b6486575aed"
    elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-202.0.dev/sdk/dartsdk-linux-x64-release.zip"
      sha256 "dd2cf0bd4454ff8301811416d02f8278cc49e1ba0cafb38c1ad786c36a6aa3c3"
    elsif OS.linux? && Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-202.0.dev/sdk/dartsdk-linux-arm64-release.zip"
        sha256 "91e5cc4a2e8b75bd342f0edd632337d216fc04a4a31a4d1caa56af79c44e1146"
      else
        url "https://storage.googleapis.com/dart-archive/channels/dev/release/3.14.0-202.0.dev/sdk/dartsdk-linux-arm-release.zip"
        sha256 "1c8c18b18eb5751c16a5852bcd931538d8ecdc63165de1062394bf0ad186bbbe"
      end
    end
  end

  conflicts_with "dart-beta", because: "dart-beta ships the same binaries"
  if OS.mac? && Hardware::CPU.intel?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.3/sdk/dartsdk-macos-x64-release.zip"
    sha256 "df957f34954c03c6551ff1ca7ce0c31038039689345f8b4d658aa5e69e28495c"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.3/sdk/dartsdk-macos-arm64-release.zip"
    sha256 "c703bcbb25ca0cc5df9109fb8272d52786ac14782437bd9e365a01985273c1cc"
  elsif OS.linux? && Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.3/sdk/dartsdk-linux-x64-release.zip"
    sha256 "549c182cffbdc6864df7509c16fec646c73fe6cb8a18c2cb572db1292f300cd7"
  elsif OS.linux? && Hardware::CPU.arm?
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.3/sdk/dartsdk-linux-arm64-release.zip"
      sha256 "c59c535623f3ab9717e8755237df695f153fb3af3bfb0f6c281b2eb4fefe669e"
    else
      url "https://storage.googleapis.com/dart-archive/channels/stable/release/3.13.3/sdk/dartsdk-linux-arm-release.zip"
      sha256 "404cf65532c20a51dd5831c089fec252d04c187f0a46a7e73d1121fae8e2a4d9"
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
