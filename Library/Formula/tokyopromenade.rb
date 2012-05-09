require 'formula'

class Tokyopromenade < Formula
  url 'http://fallabs.com/tokyopromenade/tokyopromenade-0.9.22.tar.gz'
  homepage ''
  md5 '438b45ad50ceee6c1738dfa5377e387a'

  # depends_on 'cmake' => :build

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    # system "cmake . #{std_cmake_parameters}"
    system "make install"
  end

  def test
    # This test will fail and we won't accept that! It's enough to just
    # replace "false" with the main program this formula installs, but
    # it'd be nice if you were more thorough. Test the test with
    # `brew test tokyopromenade`. Remove this comment before submitting
    # your pull request!
    system "false"
  end
end
