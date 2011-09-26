require "splitter/version"

module Splitter
  class << self
    DEFAULT_BATCH_SIZE = 100

    def split(filename, options)
      start_wrapper = options[:start_wrapper] || (raise ArgumentError, "A starting wrapper tag (:start_wrapper) must be provided.")
      end_wrapper = options[:end_wrapper] || (raise ArgumentError, "An ending wrapper tag (:end_wrapper) must be provided.")
      splitter = options[:splitter] || (raise ArgumentError, "A splitter tag (:splitter) must be provided.")
      splitter = "</#{splitter}>" unless splitter =~ /\<\/.+\>/
      batch_size = options[:batch_size] || DEFAULT_BATCH_SIZE

      s = ""
      count = 0
      File.open(filename) do |f|
        while(line = f.read(1024))
          while(i = line.index(splitter))
            count += 1
            s << "#{line[0...i]}#{splitter}"

            if count > 0 && count % batch_size == 0
              s << end_wrapper
              yield s
              s.clear
              s << start_wrapper
              count = 0
            end

            line = line[(i+splitter.size)..-1]
          end

          s << line unless line.empty?
        end
      end

      yield s unless s.empty? || s =~ /#{start_wrapper}\s*#{end_wrapper}/
    end
  end
end
