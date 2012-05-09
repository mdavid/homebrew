require 'formula'

class Tornado < Formula
  url 'http://github.com/downloads/facebook/tornado/tornado-2.1.1.tar.gz'
  homepage 'http://www.tornadoweb.org/'
  md5 '3cfa12efec87a26e013128388e1e6aa7'

  # depends_on 'cmake' => :build

  def install
    system "python setup.py build"
    #system "./configure", "--disable-debug", "--disable-dependency-tracking",
    #                      "--prefix=#{prefix}"
    # system "cmake . #{std_cmake_parameters}"
    system "python setup.py install", "--prefix=#{prefix}"
  end

  def test
    # This test will fail and we won't accept that! It's enough to just
    # replace "false" with the main program this formula installs, but
    # it'd be nice if you were more thorough. Test the test with
    # `brew test tornado`. Remove this comment before submitting
    # your pull request!
    system "false"
  end
end
