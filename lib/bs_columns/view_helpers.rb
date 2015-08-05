module BsColumns
  module ViewHelpers
    def bs_column(options = {}, &block)
      options = (options || {}).symbolize_keys
      @bs_columns ||= {}
      (@bs_columns[options[:name].to_s] ||= []) << {
          content: capture(&block),
          options: options
        }
      nil
    end

    def bs_columns(col_options, name=nil)
      # Const
      visible = { xs: %i(xs sm md lg), sm: %i(sm md lg), md: %i(md lg), lg: %i(lg) }
      total_columns = 12.0

      # We'll add the row classes before each row, and optionally hidden-rows
      name = name.to_s
      rows = @bs_columns[name].map do |row|
        { cols: [], visible_rows: Set.new, block: row }
      end
      # Flush
      @bs_columns.delete(name)

      # For each couple (ex: sm: 6, md: 3...)
      col_options = col_options.symbolize_keys
      option_keys = col_options.keys
      col_options.each do |type, cols|
        size = total_columns / cols
        raise "Unauthorized number of columns: #{cols}" if size.to_i != size
        rows.each_with_index do |row, index|
          row[:cols] << "col-#{type}-#{size.to_i}"
          if 0 != index
            if 0 == (index % cols)
              visible[type].any? do |t|
                stop = t != type && col_options.has_key?(t)
                row[:visible_rows] << t unless stop
                stop
              end
            end
          else
            row[:visible_rows] += visible[type]
          end
        end
      end

      # render
      rows.inject([]) do |acc, row|
        s = []
        if option_keys.length > 1
          vr = row[:visible_rows]
          s << 'row' if vr.length > 0
          if vr.length != visible.length && !option_keys.all? { |t| vr.include?(t) }
            s += vr.map { |t| "visible-#{t}" }
          end
        end
        html_options = row[:block][:options][:html] || {}
        acc << content_tag(:div, '', class: s.join(' ')) unless s.empty?
        acc << content_tag(:div,
          h(row[:block][:content]),
          html_options.merge(class: (row[:cols] + [html_options[:class]]).compact.join(' '))
        )
      end.join("\n").html_safe
    end
  end
end