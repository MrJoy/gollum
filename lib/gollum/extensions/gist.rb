module Gollum
  class GistLink < Gollum::ExtensionTag
    def render
      args = @arguments.split('|')
      gist = args.first
      file = (args.length > 1) ? ("?file=" + args[1]) : ""
      %{<script src="http://gist.github.com/#{gist}.js#{file}" type="text/javascript"></script>}
    end
  end
end

Gollum::ExtensionTag.register_extension_tag('gist', Gollum::GistLink)
