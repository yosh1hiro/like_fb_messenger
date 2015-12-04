module FiChat
  class Member
    include ChatModule

    attr_reader :id, :last_name, :first_name, :image, :name, :access_token, :type

    def initialize(params)
      @id = params['id']
      @last_name = params['last_name']
      @first_name = params['first_name']
      @name = params['name'] || "#{@last_name}#{@first_name}"
      @image = params['image']
      @access_token = params[:access_token] if params[:me]
      @type = type
    end

    def type
    end
  end
end
