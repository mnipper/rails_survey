class ResponseExportPolicy < ResponsePolicy
  
  def initialize(user, record)
    @user = user
    @record = record
  end
  
  def new?
    download_privileges
  end
  
  def create?
    download_privileges
  end
  
  def update?
    download_privileges
  end
  
  def edit?
    download_privileges
  end
  
  def destroy?
    @user.admin?
  end
  
  def download_project_responses?
    download_privileges
  end
  
  def download_instrument_responses?
    download_privileges
  end
  
  def download_project_response_images?
    download_privileges
  end
  
  def download_instrument_response_images?
    download_privileges
  end
  
  def download_instrument_spss_csv?
    download_privileges 
  end
  
  def download_spss_syntax_file?
    download_privileges 
  end
  
  def download_value_labels_csv?
    download_privileges 
  end
  
  private
  def download_privileges
    @user.admin? || @user.manager? || @user.analyst? 
  end
  
end 