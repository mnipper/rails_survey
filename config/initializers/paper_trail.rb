module PaperTrail
  class Version
    def creator
      user = User.find_by_id(self.whodunnit.to_i)
      user ? user.email : nil
    end
  end
end
