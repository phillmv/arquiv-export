# quick hack to incorporate hashtags into the pipeline, see below.
module PipelineFilter
  class HashtagFilter < HTML::Pipeline::Filter
    HASHTAG_REGEX = /(\s|^)(?<hashtag>#[A-Za-z0-9\-\.\_]+)/

    # Don't look for mentions in text nodes that are children of these elements
    IGNORE_PARENTS = %w(pre code a style script).to_set
    def call
      doc.search('.//text()').each do |node|
        content = node.to_html
        next unless content.include?('#')
        next if has_ancestor?(node, IGNORE_PARENTS)
        html = render_hashtags(content)
        next if html == content
        node.replace(html)
      end
      doc
    end

    def render_hashtags(str)
      str.gsub(HASHTAG_REGEX) do |match|

        context[:scope].link_to match, search_url(match)
        # "<a href=\"#{search_url(match)}\">#{match}</a>"
      end
    end

    def search_url(str)
      "/tags/#{str.gsub("#","").strip}.html"
    end
  end
end
