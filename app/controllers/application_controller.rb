class ApplicationController < Sinatra::Base
    configure do
        set :views, 'app/views'
        set :method_override, true
      end
    
      get '/' do
        erb :welcome
      end

    # see all puppies on index
    get '/puppies' do
      @puppies = Puppy.all
      erb :index
    end

    # form for creating new puppy
    get '/puppies/new' do
      erb :new_puppies
    end

    # see page w individual puppy 
    get '/puppies/:id' do 
      @puppy = find_puppy(params)
      erb :show_puppy
    end

    # create new puppy
    post '/puppies' do 
      puppy = Puppy.create(params)
      redirect "/puppies/#{puppy.id}"
    end

    # form to update an existing puppy
    get '/puppies/:id/edit' do 
      @puppy = find_puppy(params)
      erb :update_puppy
    end

    # updating existing puppy
    patch '/puppies/:id' do 
      puppy = find_puppy(params)
      puppy.update(name: params[:name], breed:params[:breed])
      redirect "/puppies/#{puppy.id}"
    end

    # deleting an exsiting pupy
    delete '/puppies/:id' do 
      puppy = find_pupy(params)
      puppy.destroy
      redirect "/puppies"
    end


  # helper method 
  def find_puppy(params)
    Puppy.find(params[:id])
  end
    
end
