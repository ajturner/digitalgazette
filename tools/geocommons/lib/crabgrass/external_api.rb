module Crabgrass
  class ExternalAPI

=begin
     {
      :overlay_page => {
        :model => Geocommons::Overlay,
        :methods => {
          :find => "",
          :create => "",
          :authenticate => ""
        },
        :query_builder => {
          :keywords => {
            :
          },
          :
          "tags" => ""
        }
      }
  }
=end

    #
    #
    @@registered_apis = HashWithIndifferentAccess.new
    attr :name

    def initialize(name)
      @name = name
    end

    def self.registered_apis
      @@registered_apis
    end

    def self.for(name)
      registered?(name)? new(name) : nil
    end

    def self.registered?(name)
      registered_apis.keys.include?(name)
    end
    
    def map_table
      @@registered_apis[name]
    end

    def model
      map_table[:model]
    end

    def get_method(method)
      map_table[:methods][method]
    end

    def key_value_separator
      query_builder[:key_value_separator] || "="
    end

    def argument_separator
      query_builder || "&"
    end

    def query_builder
       map_table[:query_builder]
    end

    # calls the mapped method
    def call(method_name, *args)
      #debugger
      model.method(get_method(method_name.to_sym).to_sym).call(args)
    end

    #
    #
    # Call this method in your api specification
    #
    #
    def self.register(page_type, hash)
      @@registered_apis[page_type] = hash
    end

    # loads the api spec from yml
    #
    # OPTIONS:
    #
    # :remote => true   # loads the .yml from a external source
    # :auth => "authkey" # pass an auth key to load the apispec
    # TODO enable authentication
    def self.load(name, file_locator, options={:remote => false})


      if options[:remote]
        require 'rubygems'
        require 'open-uri'
        file = open(file_locator)
      else
        file = File.read(file_locator)
      end
      self.register(YAML.load(file).to_hash[name])
    end


    def self.clear!
      @@registered_apis = { }
    end


  end
end