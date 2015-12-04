module FiChat
  class Members
    attr_reader :members
    def initialize(members)
      @members = members
    end

    def add(member)
      @members << member
    end

    def find(klass, id)
      @members.find { |m| m.class == klass && m.id == id }
    end

    def users_list
      @users_list = @members.map { |m| [m.id, m] }.to_h
    end

    def find_user(id)
      users_list[id]
    end
  end
end
