module PaperTrail
  class Version
    def creator
      user = User.find_by_id(self.whodunnit.to_i)
      user ? user.email : nil
    end

    def versioned(object)
      object.version_at(self.created_at - 1)
    end
  end
end
