class User < ApplicationRecord

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2, :facebook, :microsoft_graph, :linkedin, :github, :twitter, :quickbooks_oauth2]

  has_many :posts
  has_many :visits, class_name: "Ahoy::Visit"

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end


  # For Omniauth stuff


  def self.from_omniauth(auth, controller_params = false)
    unless controller_params
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email || "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com"
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name   # assuming the user model has a name
        user.img = auth.info.image # assuming the user model has an image
        # If you are using confirmable and the provider(s) you use validate emails,
        # uncomment the line below to skip the confirmation emails.
        # user.skip_confirmation! unless user.email["change@me"]
      end
    else
      # specific to Quickbooks - it would be different from others
      # given the variables that I need to save, I have to customized it
      realm_id = controller_params['realmId']
      auth = auth.refresh! if auth.expired?
      info = auth.info.to_h
      name = "#{info["givenName"]} #{info["familyName"]}"
      email = info["email"]
      uid = auth.uid
      provider = auth.provider
      credentials = auth.credentials.to_h
      token = credentials["token"]
      refresh_token = credentials["refresh_token"]
      expires = credentials["expires"]
      expires_at = credentials["expires_at"]

      user = User.where(uid: uid).first || User.where(email: email).first

      # Uncomment the section below if you want users to be created if they don't exist
        unless user
            user = User.create(name: name,
               email: email,
               password: Devise.friendly_token[0,20],
               provider: provider,
               uid: uid,
               token: token,
               refresh_token: refresh_token,
               expires: expires,
               expires_at: expires_at,
               realm_id: realm_id

            )
        end

      # It has to go after the user creation.
      unless user.token.blank?
        user.update_attribute(:token, token)
        user.update_attribute(:refresh_token, refresh_token)
        user.update_attribute(:realm_id, realm_id)
      end
        # only testing the connection directly from here
        # puts = "HERHEHREHREHRHEHREHRE"
        # qb_auth = user.token
        # qb_refresh_token = user.refresh_token
        # auth = OAuth2::AccessToken.new(::QB_OAUTH2_CONSUMER, qb_auth, { :refresh_token => qb_refresh_token })
        # service = Quickbooks::Service::Customer.new
        # service.company_id = user.realm_id
        # service.auth = auth
        # puts customers = service.query()
        # puts = "ENENENENENENEN"
        # end of code - remove later

      user
    end


  end


end
