module PaperTrail
  class Version
    def creator
      User.find(self.whodunnit.to_i).email
    end

    def versioned(object)
      object.version_at(self.created_at - 1)
    end
  end
end
