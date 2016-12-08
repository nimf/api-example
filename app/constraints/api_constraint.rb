class ApiConstraint
  attr_reader :version

  def initialize(options)
    @version = options.fetch(:version)
  end

  def matches?(request)
    request
      .headers
      .fetch(:accept) =~ /version=#{@version}(\.\d*)?(;|\z)/
  end
end
