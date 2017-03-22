class ContatosController < ApplicationController
  before_action :set_contato, only: [:show, :update, :destroy]

  # GET /contatos
  def index
    @contatos = Contato.all

    render json: @contatos
  end

  # GET /contatos/1
  def show
    render json: @contato.to_json( :include => [:pages] )
  end

  # POST /contatos
  def create
    if !params[:pages]
      render json: 'Pages required', status: :unprocessable_entity
    else
      @contato = Contato.find_by(email: contato_params[:email])
      if !@contato
        @contato = Contato.new(contato_params)
      end
      
      if @contato.save
        params[:pages].each do |page|
          unless Page.find_by(contato_id: @contato.id, url: page[:url])
            @page = Page.new(contato_id: @contato.id, url: page[:url])
            @page.save
          end
        end
        render json: @contato, status: :created, location: @contato
      else
        render json: @contato.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /contatos/1
  def update
    if @contato.update(contato_params)
      render json: @contato
    else
      render json: @contato.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contatos/1
  def destroy
    @contato.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contato
      @contato = Contato.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contato_params
      params.require(:contato).permit(:email, :contato_id)
    end
end
