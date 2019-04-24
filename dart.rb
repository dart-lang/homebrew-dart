class Dart < Formula
  desc "The Dart SDK"
  homepage "https://www.dartlang.org/"

  version "2.2.0"
  if Hardware::CPU.is_64_bit?
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.2.0/sdk/dartsdk-macos-x64-release.zip"
    sha256 "9438afb49b69ac655882036c214e343232fdcd5af24607e6058e2def33261197"
  else
    url "https://storage.googleapis.com/dart-archive/channels/stable/release/2.2.0/sdk/dartsdk-macos-ia32-release.zip"
    sha256 "78a2da74ea83ee092463a9901467492ef885f6e378353b0a44481fdf40ea81c7"
  end

  devel do
    version "2.3.0-dev.0.3"
    if Hardware::CPU.is_64_bit?
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.3.0-dev.0.3/sdk/dartsdk-macos-x64-release.zip"
      sha256 "4df7894a3ae66a49310cc06d648d7e03223fb7f6df3264936becf06111a107eb"
    else
      url "https://storage.googleapis.com/dart-archive/channels/dev/release/2.3.0-dev.0.3/sdk/dartsdk-macos-ia32-release.zip"
      sha256 "81df17430b6edd5a3747861aa262b9a5c9543700dc2ecc6532ddad5b1bc1f3fa"
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

  def caveats; <<~EOS
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
