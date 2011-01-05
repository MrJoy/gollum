# Require all of the Ruby files in the given directory. (Taken from Jekyll)
#
# path - The String relative path from here to the directory.
#
# Returns nothing.
def require_all(path)
  glob = File.join(File.dirname(__FILE__), path, '*.rb')
  Dir[glob].each do |f|
    require f
  end
end

# stdlib
require 'digest/md5'
require 'ostruct'

# external
require 'grit'
require 'github/markup'
require 'sanitize'

# ruby 1.8 compatibility
require 'gollum/ruby1.8'

# internal
require 'gollum/git_access'
require 'gollum/pagination'
require 'gollum/blob_entry'
require 'gollum/wiki'
require 'gollum/page'
require 'gollum/file'
require 'gollum/markup'
require 'gollum/albino'
require 'gollum/sanitization'

require 'gollum/extension.rb'
require_all 'gollum/extensions'

module Gollum
  VERSION = '1.1.0'

  class Error < StandardError; end

  class DuplicatePageError < Error
    attr_accessor :dir
    attr_accessor :existing_path
    attr_accessor :attempted_path

    def initialize(dir, existing, attempted, message = nil)
      @dir            = dir
      @existing_path  = existing
      @attempted_path = attempted
      super(message || "Cannot write #{@dir}/#{@attempted_path}, found #{@dir}/#{@existing_path}.")
    end
  end

  autoload :PageBuilder, 'gollum/page_builder'
end

