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

  test "page list" do
    @wiki.write_page("Bilbo Baggins", :markdown, "{{pages}}", commit_details)

    page = @wiki.page("Bilbo Baggins")
    assert_equal '<p><ul id="pages"><li>Bilbo Baggins</li></ul></p>', page.formatted_data
  end
end
