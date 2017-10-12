module RoutificApi
  # This class represents a location to be visited
  class Order
    attr_reader :id, :pickup, :dropoff, :type, :load

    # Constructor
    #
    # Optional arguments in pickup and dropoff params:
    # start: the earliest time for this visit. Default value is 00:00, if not specified.
    # end: the latest time for this visit. Default value is 23:59, if not specified.
    # duration: the length of this visit in minutes
    # demand: the capacity that this visit requires
    # location: the location of the visit. Instance of Location
    def initialize(id, params = {})
      validate(params)
      @id = id
      @pickup = RoutificApi::Visit.new(params["pickup"])
      @dropoff = RoutificApi::Visit.new(params["dropoff"])
      @type = params["type"]
      @load = params["load"]
    end

    def to_json(options)
      as_json(options).to_json
    end

    # Returns the JSON representation of this object
    # def to_json(options = nil)
    def as_json(options = nil)
      json_data = {}
      json_data["pickup"] = self.pickup.as_json
      json_data["dropoff"] = self.pickup.as_json
      json_data["type"] = self.type if self.type
      json_data["load"] = self.load if self.load

      json_data
    end

    private
    # Validates the parameters being provided
    # Raises an ArgumentError if any of the required parameters is not provided.
    # Required parameters are: pickup, dropoff
    def validate(params)
      if params["pickup"].nil?
        raise ArgumentError, "'pickup' parameter must be provided"
      elsif params["dropoff"].nil?
        raise ArgumentError, "'dropoff' parameter must be provided"
      end
    end
  end
end
