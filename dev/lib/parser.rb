class StatusCodeInfo
    attr_accessor :code
    attr_accessor :description
    attr_accessor :url

    def initialize(code, description, url)
        @code = code
        @description = description
        @url = url
    end
end

class Parser
    def self.parse(markdown)
        (markdown || "")
            .lines
            .map { |l| /^\!\[(\d+)\s\-\s(.+)\]\((.+)\)\s\s$/.match l }
            .select { |m| m != nil }
            .map { |m| m.captures }
            .map { |data| StatusCodeInfo.new(data[0].to_i, data[1], data[2]) }
    end
end