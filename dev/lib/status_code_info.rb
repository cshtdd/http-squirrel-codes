require "uri"

class StatusCodeInfo
    attr_accessor :code
    attr_accessor :description
    attr_accessor :url

    def initialize(code, description, url)
        @code = code
        @description = description
        @url = url
    end

    def full_name
        "#{@code} #{@description}"
    end

    def filename
        "#{code}.md"
    end

    def should_download_image
        not url.include? "i.imgur.com"
    end

    def image_filename
        if should_download_image
            img_extension = File.extname url
            img_filename = "#{code}"
            return "#{img_filename}#{img_extension}"
        end

        uri = URI.parse url
        return File.basename uri.path
    end

    def image_url
        if should_download_image
            return "/assets/img/code/#{image_filename}"
        end

        url
    end

    def self.pages_path(output_dir)
        File.join(output_dir, "_pages/")
    end

    def self.images_path(output_dir)
        File.join(output_dir, "assets/img/code/")
    end

    def filename_full_path(output_dir)
        pages_path = StatusCodeInfo.pages_path output_dir
        File.join(pages_path, filename)
    end

    def image_full_path(output_dir)
        images_path = StatusCodeInfo.images_path output_dir
        File.join(images_path, image_filename)
    end
end
