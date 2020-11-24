# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
class Laserboy < Formula
  desc "LaserBoy is a Linux console / frame buffer application that can open, manipulate and save DXF, ILDA and WAVE"
  homepage "https://laserboy.org"
  url "https://laserboy.org/code/LaserBoy_Current.zip"
  version "1.0.0-preview"
  sha256 "aae378f1d451622d961ff0f470c0eebe6dbabf3a46046d15e940a9721e6ea2f7"
  license "GPL-3.0-or-later"

  depends_on "boost" => :build
  depends_on "sdl2" => :build

  def install
    Dir.chdir("src")
    system "make", "-f", "Makefile.osx"
    Dir.chdir("..")
    prefix.install "LaserBoy", 
      "LaserBoy_ASCII_format.txt",
      "LaserBoy_Basics.txt",
      "LaserBoy_Correction_Amp_Parts_List.txt",
      "README.txt",
      "What_Why.txt",
      Dir["bmp"],
      Dir["ctn"],
      Dir["dxf"],
      Dir["ild"],
      Dir["txt"],
      Dir["wav"],
      Dir["wtf"]

    bin.install_symlink prefix/"LaserBoy"
  end

  test do
    system "true"
  end
end
