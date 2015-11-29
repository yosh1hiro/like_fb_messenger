module Users
  class Me
    attr_reader :id, :last_name, :first_name

    def initialize(params)
      @id = params[:id]
      @last_name = params[:last_name]
      @first_name = params[:first_name]
    end
  end

  class Other
    attr_reader :id, :last_name, :first_name, :image

    def initialize(params)
      @id = params[:id]
      @last_name = params[:last_name]
      @first_name = params[:first_name]
      @image = params[:image]
    end
  end
end
