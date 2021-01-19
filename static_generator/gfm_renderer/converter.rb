require 'yaml'
require 'fileutils'
require 'pry'

class Converter
  def initialize(input_path, output_path)
    @input_path = input_path
    @output_path = output_path
  end

  def process!
    FileUtils.mkdir_p(@output_path)
    Dir[File.join(@input_path, "2[0-9][0-9][0-9]/**/**yaml")].each do |entry|
      entry_data = YAML.load_file(entry)

      identifier = entry_data["identifier"]
      entry_data["date"] = entry_data["occurred_at"]
      body = entry_data.delete("body")
      entry_data["tags"] = extract_tags(body).join(", ")

      File.open(File.join(@output_path, identifier + ".html.markdown"), "w") do |io|
        io.puts entry_data.to_yaml
        io.puts "---"
        io.puts body
      end
    end
  end

  def extract_tags(body)
    body&.scan(PipelineFilter::HashtagFilter::HASHTAG_REGEX)&.flatten || []
  end
end
