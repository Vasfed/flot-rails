module Flot
  module ViewHelpers
    def flot_plot *series, options
      flot_options = options[:flot_options] || {}
      html_options = options[:html_options] || {}
    
      validate_options flot_options, html_options
    
      convert_times series if flot_options[:xaxis] and flot_options[:xaxis][:mode] == "time"
      html_options['data-series'] = ActiveSupport::JSON::encode(series)
      
      render :template => "flot/plot", :locals => {:series => series, :html_options => html_options, :flot_options => flot_options}
    end

    private
    def validate_options flot_options, html_options
      raise(ArgumentError, ":html_options must contain an id") if html_options[:id].nil?
    end
  
    def convert_times series
      series.each do |serie|
        serie.each do |item|
          item[0] = flot_timestamp item[0]
        end
      end
    end

    # Flot requires time attributes to be unix timestamps but in miliseconds
    def flot_timestamp time
      time.strftime("%Q")
    end
  end
end