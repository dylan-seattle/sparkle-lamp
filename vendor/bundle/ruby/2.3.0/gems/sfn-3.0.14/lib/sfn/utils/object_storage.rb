require 'sfn'

module Sfn
  module Utils

    # Storage helpers
    module ObjectStorage

      # Write to file
      #
      # @param object [Object]
      # @param path [String] path to write object
      # @param directory [Miasma::Models::Storage::Directory]
      # @return [String] file path
      def file_store(object, path, directory)
        raise NotImplementedError.new 'Internal updated required! :('
        content = object.is_a?(String) ? object : Utils._format_json(object)
        directory.files.create(
          :identity => path,
          :body => content
        )
        loc = directory.service.service.name.split('::').last.downcase
        "#{loc}://#{directory.identity}/#{path}"
      end

    end
  end
end
