class CardsController < ApplicationController
	#before_action :check_auth, :only => [:index]
	
	def index
		@cards = Card.all()
		@user_cards ||= []
		@cards.each do |card|
			if card.user_id == session[:user_id]
				@user_cards << card
			end
		end
  	end

  	def check_auth
    	user = User.authenticate(params[:email], params[:password])
	  if user
	    session[:user_id] = user.id
	    redirect_to controller: 'cards', :notice => "Logged in!"
	  else
	    flash.now.alert = "Invalid email or password"
	    render "new"
	  end
	end

	def show
    	@card = Card.find(params[:id])
  	end

  	def new
  		@card = Card.new
	end

	def edit
		@card = Card.find(params[:id])
	end

	def create
		@card = Card.new(card_params)
		@card = current_user.cards.new(card_params)
		
  		if @card.save
	    	redirect_to @card
	  	else
	   		render 'new'
	  	end
	end

	def update
		@card = Card.find(params[:id])

		if @card.update(card_params)
			redirect_to @card
		else
			render 'edit'
		end
	end
	def destroy
		@card = Card.find(params[:id])
		@card.destroy

		redirect_to cards_path
	end

	private
	  def card_params
	    params.require(:card).permit(:front, :back, :user_id)
	  end
end
