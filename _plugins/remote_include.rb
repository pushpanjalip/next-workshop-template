require 'net/http'
require 'uri'

module Jekyll

  class RemoteInclude < Liquid::Tag

    def initialize(tag_name, remote_include, tokens)
      super
      @remote_include = remote_include
    end

    def open(url)
      Net::HTTP.get(URI.parse(url.strip)).force_encoding 'utf-8'
    end

    # The remote_include is assumed to be a variable name refering to the correct URL
    def render(context)
      open("#{context[@remote_include]}")
    end

  end
end

Liquid::Template.register_tag('remote_include', Jekyll::RemoteInclude)