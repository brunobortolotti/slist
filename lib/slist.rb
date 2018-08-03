require 'slist/version'


module Slist

    class << self

        def create_list(filename, items, key = :id)
            path = Rails.root.join('tmp/slist', "#{filename}.lock")
            File.open(path, "w+") do |f|
                f.write(items.map(&:id).join(','))
            end
        end

        def read_list(filename)
            path = Rails.root.join('tmp/slist', "#{filename}.lock")
            data = File.read(path)
            data.to_s.split(',')
        end

        def peak_list(filename, size, page)
            read_list(filename).in_groups_of(size)[page]
        end

        def get_lists(prefix = nil)
            Dir.glob(Rails.root.join('tmp/slist/', "#{ prefix }*"))
        end
    end
end
