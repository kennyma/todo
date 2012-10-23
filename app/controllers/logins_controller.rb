class LoginsController < ApplicationController
  FB_API_KEY = "229102160520242"
  FB_API_SECRET = "7f38e93831ab7c3c50b8cc2ca67b5f4e"
  
  def index
    respond_to do |wants|
      wants.html
      
      wants.json do
        render :json => {
          :url => fb_client.authorization_uri(
            :scope =>  [:email, :read_friendlists, :publish_stream]
          )
        }
      end
    end
  end
  
  def is_authed
    render :json => {
      :authed => session.has_key?(:access_token),
      :keys => session.keys,
      :access_token => session[:access_token]
    }
  end
  
  def authed
    begin
      fb_client.authorization_code = params[:code]
      access_token = fb_client.access_token! :client_auth_body # => Rack::OAuth2::AccessToken    
      session[:access_token] = access_token.to_s
      # user = FbGraph::User.me(access_token).fetch # => FbGraph::User
      puts "session[:access_token]: #{session[:access_token]}"
      
      user = User.first
      user.access_token = access_token.to_s
      user.save!
      
      render :text => <<-HERE
        <script type="text/javascript">
          window.opener.TodoList.Auth.authed();
          window.close();
        </script>
      HERE
    rescue
      render :text => <<-HERE
        <script type="text/javascript">
          window.opener.open("Error in authing with Facebook");
        </script>
      HERE
    end
  end
  
private

  def fb_client
    @fb_client ||= begin
      fb_auth = FbGraph::Auth.new(FB_API_KEY, FB_API_SECRET)
      fb_client = fb_auth.client
      fb_client.redirect_uri = "http://localhost:3000/login/authed"
      fb_client
    end
  end
end