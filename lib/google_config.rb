class GoogleConfig
  
  def client_id
    ENV["GOOGLE_DRIVE_CLIENT_ID"]
  end
  
  def client_secret
    ENV["GOOGLE_DRIVE_CLIENT_SECRET"]
  end
  
  def refresh_token
    ENV["GOOGLE_DRIVE_REFRESH_TOKEN"]
  end
  
  def refresh_token=(_value)
  end
  
  def scope
    ['https://www.googleapis.com/auth/drive',
     'https://spreadsheets.google.com/feeds/',
    ]
  end
  
  def scope=(_value)
  end
  
  def save
  end
  
end
  
  #client_id
    #   client_secret
    #   refesh_token
    #   refresh_token=
    #   scope
    #   scope=
    #   save