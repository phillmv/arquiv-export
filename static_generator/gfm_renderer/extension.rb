require 'yaml'
require 'active_support/core_ext/hash/keys'

class HandleYaml < ::Middleman::Extension
  def initialize(app, options = {}, &block)
    super

    ::Tilt.register("yaml", GFMTemplate)
  end

  def manipulate_resource_list(resources)
    resources.each do |resource|
      next if resource.binary?
      next if resource.file_descriptor.nil?
      full_path = resource.file_descriptor[:full_path].to_s
      next if !full_path.index(".yaml")
      # next if resource.file_descriptor[:types].include?(:no_frontmatter)

      entry_data = YAML.load_file(full_path)

      resource.add_metadata options: {layout: "layout"}, page: entry_data
      # fmdata = data(resource.file_descriptor[:full_path].to_s).first.dup

      # Copy over special options
      # TODO: Should we make people put these under "options" instead of having
      # special known keys?
      # opts = fmdata.extract!(:layout, :layout_engine, :renderer_options, :directory_index, :content_type)
      # opts[:renderer_options].symbolize_keys! if opts.key?(:renderer_options)

      # ignored = fmdata.delete(:ignored)

      # TODO: Enhance data? NOOOO
      # TODO: stringify-keys? immutable/freeze?

      # resource.add_metadata options: opts, page: fmdata

      # resource.ignore! if ignored == true && !resource.is_a?(::Middleman::Sitemap::ProxyResource)

      # TODO: Save new template here somewhere?
    end
  end

end
