# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :login_dot_gov, {
#     name: :login_dot_gov,
#     client_id: 'urn:gov:gsa:openidconnect.profiles:sp:sso:gsa:usdr_dev', # same value as registered in the Partner Dashboard
#     idp_base_url: 'https://idp.int.identitysandbox.gov/', # login.gov sandbox environment IdP
#     ial: 1,
#     private_key: OpenSSL::PKey::RSA.new(File.read('config/private.pem')),
#     redirect_uri: 'http://localhost:3000/auth/logindotgov/callback',
#   }
# end