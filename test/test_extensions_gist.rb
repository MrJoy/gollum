require File.join(File.dirname(__FILE__), *%w[helper])

context "Gist" do
  setup do
    @path = testpath("examples/test.git")
    FileUtils.rm_rf(@path)
    Grit::Repo.init_bare(@path)
    @wiki = Gollum::Wiki.new(@path)
  end

  teardown do
    FileUtils.rm_r(File.join(File.dirname(__FILE__), *%w[examples test.git]))
  end

  test "normal gist" do
    @wiki.write_page("Bilbo Baggins", :markdown, "{{gist 1234}}", commit_details)

    page = @wiki.page("Bilbo Baggins")
    assert_equal '<p><script src="http://gist.github.com/1234.js" type="text/javascript"></script></p>', page.formatted_data
  end

  test "gist with file" do
    @wiki.write_page("Bilbo Baggins", :markdown, "{{gist 1234|some.ext}}", commit_details)

    page = @wiki.page("Bilbo Baggins")
    assert_equal '<p><script src="http://gist.github.com/1234.js?file=some.ext" type="text/javascript"></script></p>', page.formatted_data
  end
end
