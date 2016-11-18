MYUSA_KEY    = OauthCredentials.myusa_key
MYUSA_SECRET = OauthCredentials.myusa_secret
MYUSA_URL    = ENV["MYUSA_URL"] || "https://alpha.my.usa.gov"

CG_KEY       = OauthCredentials.cg_app_id
CG_SECRET    = OauthCredentials.cg_app_secret
CG_URL       = ENV["CG_URL"] || "https://login.cloud.gov"
CG_TOKEN_URL = ENV["CG_TOKEN_URL"] || "https://uaa.cloud.gov"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :myusa, MYUSA_KEY, MYUSA_SECRET, scope: "profile.email",
                                            client_options: {
                                              site: MYUSA_URL,
                                              token_url: "/oauth/authorize"
                                            }

  provider :cg,
           CG_KEY,
           CG_SECRET,
           client_options: {
             site: CG_URL,
             token_url: "#{CG_TOKEN_URL}/oauth/token"
           }
end
