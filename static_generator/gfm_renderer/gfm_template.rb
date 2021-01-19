require_relative 'pipeline_filter'
require 'pry'

class GFMTemplate < ::Tilt::Template
  def prepare
    @engine = nil
    @output = nil
  end

  def evaluate(scope, locals, &block)
    PipelineFilter::ENTRY_PIPELINE.to_html(data, {scope: scope, locals: locals})
  end
end
