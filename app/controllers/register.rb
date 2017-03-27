Autolocales::App.controllers :register do

  # Handle user registration
  get "/" do
    @email_placeholder="mail@example.com"
    render "register"
  end

  post "/" do
    err=false

    if params[:name] && params[:name].length>255
      flash[:error]="Name must be max. 255 chars."
      @name_status="has-error"
      err=true
    end
    
    # /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    if !params[:email] || params[:email].length>255
      flash[:error]="Not valid mail."
      @email_status="has-error"
      err=true
    end

    if !err && User.first(login: params[:email])
      flash[:error]="Already registered."
      @email_status="has-error"
      err=true
    end

    if !err
      name = !params[:name].empty? ? params[:name]:params[:email]
      User.create(name: name, login: params[:email], password: params[:response])
      warden.authenticate(:registration)
      redirect "/"
    else
      @name=params[:name]
      @email=params[:email]
      render "register"
    end
  end

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  
end
